-- Fills a section listing, or the home page's recent list, from the tree.
--
-- Which one it builds is decided by the `kind` metadata the Makefile passes,
-- because both read the same page set and differ only in what they show. A
-- section listing carries summaries. The home list is five titles under two
-- other sections and carries none.

package.path = 'lua/?.lua;' .. package.path
local content = require 'content'

local HOME_RECENT = 5

local function entry(p, summaries)
  local e = {url = pandoc.MetaString(p.url), title = pandoc.MetaString(p.title)}
  if p.date then e.date = pandoc.MetaString(p.date) end
  -- The summary is the front matter description and nothing else. An author
  -- who wrote none gets no line rather than an arbitrary one.
  if summaries and p.description then
    e.summary = pandoc.MetaString(p.description)
  end
  return pandoc.MetaMap(e)
end

function Pandoc(doc)
  local m = doc.meta
  local kind = m.kind and pandoc.utils.stringify(m.kind) or 'section'
  local pages = content.all{
    drafts = m.drafts ~= nil,
    future = m.future ~= nil,
  }

  local list, summaries = {}, kind == 'section'
  if kind == 'home' then
    local posts = content.section_pages(pages, 'blog')
    for i = 1, math.min(HOME_RECENT, #posts) do list[i] = entry(posts[i], false) end
    m.emptytext = pandoc.MetaString('Nothing published yet.')
  else
    local section = pandoc.utils.stringify(m.url):match('^/([^/]+)/')
    for _, p in ipairs(content.section_pages(pages, section)) do
      list[#list + 1] = entry(p, summaries)
    end
    m.emptytext = pandoc.MetaString('Nothing published here yet.')
  end

  if #list == 0 then
    m.empty = pandoc.MetaString('1')
  else
    m.entries = pandoc.MetaList(list)
    m.recent = pandoc.MetaList(list)
  end

  doc.meta = m
  return doc
end
