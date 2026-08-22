-- The set of pages, for the things that need to see more than one document.
--
-- Section listings, the home page's recent list, the feed and the sitemap all
-- fold over every page, and pandoc renders one document at a time. So each of
-- those reads the tree through here. Six content files makes reading them
-- again cheaper than maintaining an index file and a make rule to rebuild it.

package.path = 'lua/?.lua;' .. package.path
local dates = require 'dates'

local M = {}

local ROOT = 'content'

-- The same reader extensions the Makefile passes, so a page parsed here for
-- the feed matches the one parsed for its own HTML.
local FORMAT = 'markdown-auto_identifiers-markdown_in_html_blocks-implicit_figures'

local function read(path)
  local f = io.open(path)
  if not f then return nil end
  local s = f:read('a')
  f:close()
  return s
end

local function is_dir(path)
  return pcall(pandoc.system.list_directory, path)
end

local function meta_str(m, k)
  return m[k] and pandoc.utils.stringify(m[k]) or nil
end

local function first_paragraph(blocks)
  for _, b in ipairs(blocks) do
    if b.tag == 'Para' then return pandoc.utils.stringify(b) end
  end
  return nil
end

--- Read one file into the facts every consumer needs.
local function load(src, section)
  local text = read(src)
  if not text then return nil end
  local doc = pandoc.read(text, FORMAT)
  local name = src:match('([^/]+)%.md$')
  local is_section = name == '_index'
  local slug = meta_str(doc.meta, 'slug') or name

  local url
  if is_section then
    url = '/' .. section .. '/'
  elseif section then
    url = '/' .. section .. '/' .. slug .. '/'
  else
    url = '/' .. slug .. '/'
  end

  local date = meta_str(doc.meta, 'date')
  return {
    src = src,
    section = section,
    slug = slug,
    url = url,
    is_section = is_section,
    title = meta_str(doc.meta, 'title') or slug,
    description = meta_str(doc.meta, 'description'),
    summary = meta_str(doc.meta, 'description') or first_paragraph(doc.blocks),
    date = date,
    sort = date and dates.sortkey(date) or 0,
    draft = doc.meta.draft == true,
    blocks = doc.blocks,
  }
end

--- Every page, filtered by the build mode.
-- @param opts table {drafts=boolean, future=boolean}
function M.all(opts)
  local now = tonumber(os.date('!%Y%m%d%H%M%S'))
  local pages = {}

  local function keep(p)
    if p.draft and not opts.drafts then return false end
    if p.sort > 0 and not opts.future and p.sort > now then return false end
    return true
  end

  local function add(src, section)
    local p = load(src, section)
    if p and keep(p) then pages[#pages + 1] = p end
  end

  for _, entry in ipairs(pandoc.system.list_directory(ROOT)) do
    local path = ROOT .. '/' .. entry
    if is_dir(path) then
      for _, f in ipairs(pandoc.system.list_directory(path)) do
        if f:match('%.md$') then add(path .. '/' .. f, entry) end
      end
    elseif entry:match('%.md$') and entry ~= '404.md' then
      -- 404 renders to /404.html, not a directory, and is not a page of the
      -- site. It is built on its own and listed nowhere.
      add(path, nil)
    end
  end

  return pages
end

--- The pages a section lists. Only the blog is dated, so only it sorts by
--- date. Anything else keeps discovery order, which is alphabetical.
function M.section_pages(pages, section)
  local out = {}
  for _, p in ipairs(pages) do
    if p.section == section and not p.is_section then out[#out + 1] = p end
  end
  if section == 'blog' then
    table.sort(out, function(a, b)
      if a.sort ~= b.sort then return a.sort > b.sort end
      return a.slug < b.slug
    end)
  end
  return out
end

return M
