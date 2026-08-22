-- Syntax highlighting, translated from skylighting's class names to Chroma's.
--
-- A module rather than a filter, because the feed renders every post a second
-- time and needs the same treatment.
--
-- The stylesheet carries Chroma's vocabulary, inherited from Hugo, and it is
-- the asset this migration is built around not touching. So the markup moves
-- instead. The class lands on the <code>, never the <pre>: `.chroma
-- { background: none }` and `pre { background: ... }` are both single-class
-- rules, so on the <pre> it would strip the block's surface.
--
-- Highlighting runs in the writer, after filters, so a filter cannot
-- post-process it. Each block is written on its own and the result rewritten.

local M = {}

local CHROMA = {
  kw = 'k',  cf = 'k',  at = 'k',
  im = 'kn', pp = 'kn',
  dt = 'kt',
  bu = 'nb', cn = 'nb',
  fu = 'nf', ex = 'nf',
  st = 's',  ch = 's',  vs = 's', ss = 's', sc = 's',
  dv = 'm',  bn = 'm',  fl = 'm',
  co = 'c',  cv = 'c',  an = 'c', wa = 'c',
  do_ = 'cs',
  al = 'err', er = 'err',
}

local ESC = {['&'] = '&amp;', ['<'] = '&lt;', ['>'] = '&gt;', ['"'] = '&quot;'}

local function escape(s)
  return (s:gsub('[&<>"]', ESC))
end

-- One source line arrives as one <span id="cbN-M"> carrying an empty anchor.
-- Neither is wanted and no writer option suppresses them.
local function strip_line_wrapper(line)
  local inner = line:match('^<span id="cb%d+%-%d+"><a href="#cb%d+%-%d+"[^>]*></a>(.*)</span>$')
  return inner or line
end

local function remap(line)
  return (line:gsub('(%s*)class="(%a+)"', function(space, cls)
    local key = cls == 'do' and 'do_' or cls
    local mapped = CHROMA[key]
    -- An unmapped token has no rule in the stylesheet, so the attribute goes
    -- and the bare span is inert. ostat emitted no span at all for these.
    return mapped and (space .. 'class="' .. mapped .. '"') or ''
  end):gsub('<span>([^<]*)</span>', '%1'))
end

function M.block(cb)
  local lang = cb.classes[1]
  local html = pandoc.write(pandoc.Pandoc({cb}), 'html',
    pandoc.WriterOptions{wrap_text = 'wrap-preserve'})

  local body = html:match('<code class="sourceCode [^"]*">(.*)</code></pre></div>')
  if not body then
    -- Skylighting has no lexer for this language, or the fence named none.
    return pandoc.RawBlock('html',
      '<pre><code class="language-text">' .. escape(cb.text) .. '\n</code></pre>')
  end

  local out = {}
  for line in (body .. '\n'):gmatch('(.-)\n') do
    out[#out + 1] = remap(strip_line_wrapper(line))
  end

  return pandoc.RawBlock('html', string.format(
    '<pre><code class="chroma language-%s">%s\n</code></pre>',
    escape(lang), table.concat(out, '\n')))
end

return M
