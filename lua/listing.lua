-- Fills a section listing, or the home page's recent list, from the tree.
--
-- Which one it builds is decided by the `kind` metadata the Makefile passes.
-- Sections list their pages. Home selects featured projects and recent posts.

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
  if p.status then e.status = pandoc.MetaString(p.status) end
  if p.source then e.source = pandoc.MetaString(p.source) end
  if p.tags and #p.tags > 0 then
    local tags = {}
    for _, tag in ipairs(p.tags) do tags[#tags + 1] = pandoc.MetaString(tag) end
    e.tags = pandoc.MetaList(tags)
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
    local posts = content.section_pages(pages, 'articles')
    for i = 1, math.min(HOME_RECENT, #posts) do list[i] = entry(posts[i], true) end
    local projects = {}
    for _, p in ipairs(content.featured_projects(pages)) do
      projects[#projects + 1] = entry(p, true)
    end
    if #projects > 0 then m.featured_projects = pandoc.MetaList(projects) end
  else
    local section = pandoc.utils.stringify(m.url):match('^/([^/]+)/')
    for _, p in ipairs(content.section_pages(pages, section)) do
      list[#list + 1] = entry(p, summaries)
    end
    m.emptytext = pandoc.MetaString('Nothing published here yet.')
  end

  if #list == 0 and kind ~= 'home' then
    m.empty = pandoc.MetaString('1')
  else
    if kind == 'home' then
      if #list > 0 then m.recent = pandoc.MetaList(list) end
    else
      m.entries = pandoc.MetaList(list)
    end
  end

  doc.meta = m
  return doc
end
