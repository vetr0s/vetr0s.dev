-- Date formatting for the three places a stamp is read.
--
-- A front matter date is either 2026-07-12 or 2026-07-12T14:05:00. The raw
-- string is never reformatted, because <time datetime> has to round-trip
-- whatever was authored. The other two forms are derived.

local M = {}

local LONG = {'January', 'February', 'March', 'April', 'May', 'June', 'July',
              'August', 'September', 'October', 'November', 'December'}
local ABBR = {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
              'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'}

-- os.time reads its table as local time, so the resulting epoch is offset by
-- the machine's zone. Noon keeps that offset from crossing a day boundary,
-- which is all the weekday name needs.
local function weekday(y, m, d)
  return os.date('!%a', os.time{year = y, month = m, day = d, hour = 12})
end

--- Split a front matter stamp into its parts.
-- @return table {y, m, d, hms} or nil when the stamp is unparseable
function M.parse(raw)
  local y, m, d = raw:match('^(%d%d%d%d)-(%d%d)-(%d%d)')
  if not y then return nil end
  local hms = raw:match('^%d%d%d%d%-%d%d%-%d%dT(%d%d:%d%d:%d%d)') or '00:00:00'
  return {y = tonumber(y), m = tonumber(m), d = tonumber(d), hms = hms}
end

--- "July 12, 2026". The day is not zero padded, which %d would do.
function M.long(raw)
  local t = M.parse(raw)
  if not t then return raw end
  return string.format('%s %d, %d', LONG[t.m], t.d, t.y)
end

--- "Sun, 12 Jul 2026 00:00:00 +0000", for the feed.
function M.rfc822(raw)
  local t = M.parse(raw)
  if not t then return raw end
  return string.format('%s, %02d %s %d %s +0000',
    weekday(t.y, t.m, t.d), t.d, ABBR[t.m], t.y, t.hms)
end

--- Sortable integer. Undated pages sort last.
function M.sortkey(raw)
  local t = M.parse(raw)
  if not t then return 0 end
  local h, mi, s = t.hms:match('(%d%d):(%d%d):(%d%d)')
  return ((t.y * 10000 + t.m * 100 + t.d) * 1000000)
       + (tonumber(h) * 10000 + tonumber(mi) * 100 + tonumber(s))
end

return M
