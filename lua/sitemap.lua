-- Every page the build publishes, home first.

package.path = 'lua/?.lua;' .. package.path
local content = require 'content'

function Pandoc(doc)
  local m = doc.meta
  local base = pandoc.utils.stringify(m.site.base_url)
  local pages = content.all{drafts = m.drafts ~= nil, future = m.future ~= nil}

  local urls = {pandoc.MetaMap{loc = pandoc.MetaString(base .. '/')}}
  table.sort(pages, function(a, b) return a.url < b.url end)
  for _, p in ipairs(pages) do
    local u = {loc = pandoc.MetaString(base .. p.url)}
    if p.date then u.lastmod = pandoc.MetaString(p.date:sub(1, 10)) end
    urls[#urls + 1] = pandoc.MetaMap(u)
  end

  m.urls = pandoc.MetaList(urls)
  doc.meta = m
  return doc
end
