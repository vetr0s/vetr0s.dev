-- Derives everything the page and section templates read that is not already
-- in front matter.
--
-- Pandoc's template language has $if$, $for$ and interpolation and nothing
-- else, so every computed value has to arrive as a variable. Each is written
-- back as a MetaString, which the writer escapes on interpolation and does not
-- reparse as markdown.

package.path = 'lua/?.lua;' .. package.path
local dates = require 'dates'

local DESCRIPTION_LIMIT = 160

local function meta_str(m, k)
  return m[k] and pandoc.utils.stringify(m[k]) or nil
end

-- Cuts at the last word boundary inside the limit and marks the cut. The limit
-- counts characters, not bytes, so a multibyte character cannot be split.
local function truncate(s, limit)
  if pandoc.text.len(s) <= limit then return s end
  local head = pandoc.text.sub(s, 1, limit)
  local cut = head:match('^(.*)%s%S*$') or head
  return (cut:gsub('%s+$', '')) .. '\u{2026}'
end

local function first_paragraph(blocks)
  for _, b in ipairs(blocks) do
    if b.tag == 'Para' then return pandoc.utils.stringify(b) end
  end
  return nil
end

-- A section's crumb is its title, not its directory name.
local function section_title(section)
  local f = io.open('content/' .. section .. '/_index.md')
  if not f then return section end
  local doc = pandoc.read(f:read('a'),
    'markdown-auto_identifiers-markdown_in_html_blocks-implicit_figures')
  f:close()
  return meta_str(doc.meta, 'title') or section
end

-- Pandoc records the marker style a list was authored with and reproduces it
-- as an attribute. The stylesheet numbers lists itself.
function OrderedList(l)
  l.style = 'DefaultStyle'
  l.delimiter = 'DefaultDelim'
  return l
end

-- Pandoc derives column widths from how the source table was formatted and
-- emits a <colgroup> fixing them. The stylesheet sizes tables, so drop them.
function Table(t)
  for _, spec in ipairs(t.colspecs) do spec[2] = nil end
  return t
end

function Pandoc(doc)
  local m = doc.meta
  local url = meta_str(m, 'url') or '/'
  local kind = meta_str(m, 'kind') or 'page'
  local site = m.site
  local sitetitle = pandoc.utils.stringify(site.title)

  local title = meta_str(m, 'title') or sitetitle
  local is_home = kind == 'home'
  local section = url:match('^/([^/]+)/[^/]+/')
  local own_section = url:match('^/([^/]+)/')

  m.pagetitle = pandoc.MetaString(
    is_home and sitetitle or (title .. ' \u{b7} ' .. sitetitle))

  local desc = meta_str(m, 'description')
             or first_paragraph(doc.blocks)
             or pandoc.utils.stringify(site.description)
  m.pagedesc = pandoc.MetaString(truncate(desc, DESCRIPTION_LIMIT))

  m.ogtype = pandoc.MetaString(section == 'articles' and 'article' or 'website')
  m.pageurl = pandoc.MetaString(pandoc.utils.stringify(site.base_url) .. url)
  m.socialtitle = pandoc.MetaString(title)

  local image = meta_str(m, 'image')
  if image then
    if not meta_str(m, 'image_alt') then error('image requires image_alt') end
    if image:sub(1, 1) == '/' then image = pandoc.utils.stringify(site.base_url) .. image end
    m.socialimage = pandoc.MetaString(image)
  end

  -- Only articles publishes a feed, and the home page advertises the same one.
  if is_home then
    m.feed = pandoc.MetaString(pandoc.utils.stringify(site.base_url) .. '/index.xml')
    m.feedpath = pandoc.MetaString('/index.xml')
  elseif own_section == 'articles' and kind == 'section' then
    m.feed = pandoc.MetaString(pandoc.utils.stringify(site.base_url) .. '/articles/index.xml')
    m.feedpath = pandoc.MetaString('/articles/index.xml')
  end

  if is_home then
    m.is_home = pandoc.MetaString('1')
  elseif kind == 'page' and section then
    m.parent_url = pandoc.MetaString('/' .. section .. '/')
    m.parent_crumb = pandoc.MetaString(section_title(section):lower())
  else
    m.crumb = pandoc.MetaString(title:lower())
  end

  local raw = meta_str(m, 'date')
  if raw then
    m.date_raw = pandoc.MetaString(raw)
    m.date_long = pandoc.MetaString(dates.long(raw))
  end

  doc.meta = m
  return doc
end
