-- Margin notes, in the Tufte shape the stylesheet is written against.
--
-- Pandoc parses [^label] into a Note holding only its content. The label is
-- discarded by the reader, and a second reference to one note arrives as a
-- second Note with identical content rather than as a back-reference. So notes
-- are identified by their rendered content and numbered by first appearance.
-- The id only binds a label to its checkbox within one page, and nothing links
-- to it from outside.

local LABEL = '<label for="sn-%d" class="margin-toggle sidenote-number"></label>'
local BODY  = '<input type="checkbox" id="sn-%d" class="margin-toggle">'
           .. '<span class="sidenote">%s</span>'

local seen, next_id = {}, 0

-- Notes render as inlines, not blocks. A <p> inside the span would break the
-- gutter layout.
local function inline_html(blocks)
  local inlines = {}
  for _, b in ipairs(blocks) do
    if b.tag == 'Para' or b.tag == 'Plain' then
      for _, i in ipairs(b.content) do inlines[#inlines + 1] = i end
    end
  end
  local opts = pandoc.WriterOptions{wrap_text = 'wrap-none'}
  return pandoc.write(pandoc.Pandoc({pandoc.Plain(inlines)}), 'html', opts)
    :gsub('%s+$', '')
end

function Note(e)
  local html = inline_html(e.content)
  local id = seen[html]
  if id then
    return pandoc.RawInline('html', LABEL:format(id))
  end
  next_id = next_id + 1
  seen[html] = next_id
  return pandoc.RawInline('html',
    LABEL:format(next_id) .. BODY:format(next_id, html))
end
