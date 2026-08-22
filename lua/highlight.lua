-- Applies the Chroma translation to a page. The work is in lua/code.lua,
-- which the feed uses too.

package.path = 'lua/?.lua;' .. package.path
local code = require 'code'

function CodeBlock(cb)
  return code.block(cb)
end
