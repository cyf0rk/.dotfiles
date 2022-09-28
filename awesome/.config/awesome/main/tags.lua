-- Standard awesome library
local awful = require'awful'

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get ()
    local tags = {}

    awful.screen.connect_for_each_screen(function(s)
        -- Each screen has its own tag table.
        tags[s] = awful.tag(
            { "1", "2" , "3", "4", "5", "6", "7", "8", "9", "10" }, s, RC.layouts[1]
            -- { "一", "二", "三", "四", "五", "六", "七", "八", "九", "十" }, s, RC.layouts[1]
            -- { "", "", "", "","", "", "", "ﭮ", "", "" }, s, RC.layouts[1]
        )
    end)

    return tags
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
