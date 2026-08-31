-- The RSS feed. Blog posts only, each carrying its front matter description.

package.path = 'lua/?.lua;' .. package.path
local content = require 'content'
local dates = require 'dates'

local XML = {['&'] = '&amp;', ['<'] = '&lt;', ['>'] = '&gt;', ['"'] = '&quot;'}

local function xml_escape(s)
  return (s:gsub('[&<>"]', XML))
end

function Pandoc(doc)
  local m = doc.meta
  local site = m.site
  local base = pandoc.utils.stringify(site.base_url)
  local pages = content.all{drafts = m.drafts ~= nil, future = m.future ~= nil}
  local posts = content.section_pages(pages, 'articles')

  local items = {}
  for _, p in ipairs(posts) do
    if not p.description then
      error(p.src .. ': description is required for RSS')
    end
    local permalink = base .. p.url
    local item = {
      title = pandoc.MetaString(xml_escape(p.title)),
      link = pandoc.MetaString(xml_escape(permalink)),
      pubdate = pandoc.MetaString(dates.rfc822(p.date)),
      description = pandoc.MetaString(xml_escape(p.description)),
    }
    if p.tags and #p.tags > 0 then
      local tags = {}
      for _, tag in ipairs(p.tags) do
        tags[#tags + 1] = pandoc.MetaString(xml_escape(tag))
      end
      item.tags = pandoc.MetaList(tags)
    end
    items[#items + 1] = pandoc.MetaMap(item)
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
