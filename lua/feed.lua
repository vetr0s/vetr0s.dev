-- The RSS feed. Blog posts only, each carrying its whole content.
--
-- A feed item is read a long way from the page it came from, so the second
-- render differs from the page in two ways: notes become numbered endnotes
-- rather than margin notes, and every site-relative URL is made absolute.
-- Absolutising walks the tree rather than rewriting emitted HTML, so it cannot
-- reach inside a code span and corrupt it.

package.path = 'lua/?.lua;' .. package.path
local content = require 'content'
local code = require 'code'
local dates = require 'dates'

local REF = '<sup class="fn-ref"%s><a href="%s#fn-%d" role="doc-noteref">%d</a></sup>'

local XML = {['&'] = '&amp;', ['<'] = '&lt;', ['>'] = '&gt;', ['"'] = '&quot;'}

-- The item body is escaped here rather than by the writer. A MetaString is
-- whitespace-collapsed on interpolation, which would flatten the indentation
-- of every code block, so the body travels as a raw block instead.
local function xml_escape(s)
  return (s:gsub('[&<>"]', XML))
end

local function absolutise(blocks, base)
  local function abs(u)
    if u:match('^%a[%w+.-]*:') or u:match('^//') or u:match('^#') then return u end
    if u:sub(1, 1) == '/' then return base .. u end
    return u
  end
  -- A walk cannot see inside author-written HTML, so raw nodes get their URL
  -- attributes rewritten by pattern. The surface is only raw HTML, never prose
  -- and never a code span, both of which are their own element types.
  local URL_ATTRS = {'src', 'href', 'poster'}
  local function raw(e)
    for _, attr in ipairs(URL_ATTRS) do
      e.text = e.text:gsub('(%s' .. attr .. '=")(/[^"]*)"', function(head, u)
        return head .. base .. u .. '"'
      end)
    end
    return e
  end

  return pandoc.Pandoc(blocks):walk{
    Link = function(l) l.target = abs(l.target); return l end,
    Image = function(i) i.src = abs(i.src); return i end,
    RawBlock = raw,
    RawInline = raw,
  }
end

local function inline_html(blocks)
  local inlines = {}
  for _, b in ipairs(blocks) do
    if b.tag == 'Para' or b.tag == 'Plain' then
      for _, i in ipairs(b.content) do inlines[#inlines + 1] = i end
    end
  end
  return pandoc.write(pandoc.Pandoc({pandoc.Plain(inlines)}), 'html',
    pandoc.WriterOptions{wrap_text = 'wrap-none'}):gsub('%s+$', '')
end

--- One post's feed HTML: endnotes, absolute URLs, endnote list appended.
local function item_html(page, permalink, base)
  local doc = absolutise(page.blocks, base)
  local seen, order, n = {}, {}, 0

  doc = doc:walk{
    Note = function(e)
      local html = inline_html(e.content)
      local num = seen[html]
      -- Only the first reference is the backlink's target, so only it takes
      -- the id. A later one points at the note the first one wrote.
      local anchor = ''
      if not num then
        n = n + 1
        num = n
        seen[html] = num
        order[num] = html
        anchor = string.format(' id="fnref-%d"', num)
      end
      return pandoc.RawInline('html', REF:format(anchor, permalink, num, num))
    end,
  }

  doc = doc:walk{CodeBlock = code.block}
  local body = pandoc.write(doc, 'html',
    pandoc.WriterOptions{wrap_text = 'wrap-preserve'})

  if n == 0 then return body end

  local out = {body, '\n<div class="footnotes" role="doc-endnotes">\n<ol>\n'}
  for i = 1, n do
    out[#out + 1] = string.format(
      '<li id="fn-%d">%s <a href="%s#fnref-%d">&#8617;</a></li>\n',
      i, order[i], permalink, i)
  end
  out[#out + 1] = '</ol>\n</div>\n'
  return table.concat(out)
end

function Pandoc(doc)
  local m = doc.meta
  local site = m.site
  local base = pandoc.utils.stringify(site.base_url)
  local pages = content.all{drafts = m.drafts ~= nil, future = m.future ~= nil}
  local posts = content.section_pages(pages, 'blog')

  local items = {}
  for _, p in ipairs(posts) do
    local permalink = base .. p.url
    items[#items + 1] = pandoc.MetaMap{
      title = pandoc.MetaString(p.title),
      link = pandoc.MetaString(permalink),
      pubdate = pandoc.MetaString(dates.rfc822(p.date)),
      body = pandoc.MetaBlocks{
        pandoc.RawBlock('html', xml_escape(item_html(p, permalink, base)))},
    }
  end

  if #items > 0 then
    m.items = pandoc.MetaList(items)
    m.lastbuild = pandoc.MetaString(dates.rfc822(posts[1].date))
  end
  local selfpath = pandoc.utils.stringify(m.selfpath)
  m.selflink = pandoc.MetaString(base .. selfpath)
  -- The channel points at the page the feed belongs to, not always the root.
  m.channellink = pandoc.MetaString(base .. selfpath:gsub('index%.xml$', ''))

  doc.meta = m
  return doc
end
