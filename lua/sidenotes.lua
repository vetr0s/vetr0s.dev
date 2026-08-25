-- Numbered inline disclosures generated from Markdown footnotes.
--
-- Pandoc parses [^label] into a Note holding only its content. The label is
-- discarded by the reader, and a second reference to one note arrives as a
-- second Note with identical content rather than as a back-reference. So notes
-- are identified by their rendered content and numbered by first appearance.
-- The id only binds a label to its checkbox within one page, and nothing links
-- to it from outside.

local NOTE = '<input type="checkbox" id="sn-%d" class="margin-toggle"'
          .. ' aria-label="Toggle sidenote %d" aria-controls="sn-body-%d">'
          .. '<label for="sn-%d" class="margin-toggle sidenote-number"></label>'
          .. '<span id="sn-body-%d" class="sidenote">%s</span>'
local REF = '<label for="sn-%d" class="margin-toggle sidenote-number"'
         .. ' aria-label="Show sidenote %d"></label>'

local seen, next_id = {}, 0

-- Notes render as inlines. A paragraph inside the span would be invalid here.
local function inline_html(blocks)
  local inlines = {}
  for _, b in ipairs(blocks) do
    if b.tag ~= 'Para' and b.tag ~= 'Plain' then
      error('sidenotes support paragraph content only, found ' .. b.tag)
    end
    for _, i in ipairs(b.content) do inlines[#inlines + 1] = i end
  end
  local opts = pandoc.WriterOptions{wrap_text = 'wrap-none'}
  return pandoc.write(pandoc.Pandoc({pandoc.Plain(inlines)}), 'html', opts)
    :gsub('%s+$', '')
end

function Note(e)
  local html = inline_html(e.content)
  local id = seen[html]
  if id then
    return pandoc.RawInline('html', REF:format(id, id))
  end
  next_id = next_id + 1
  seen[html] = next_id
  return pandoc.RawInline('html',
    NOTE:format(next_id, next_id, next_id, next_id, next_id, html))
end
