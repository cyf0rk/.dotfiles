local awful = require("awful")

local keyboards = { "us", "hr" }

local _M = {}

function _M.change_kayboard_layout()
    table.insert(keyboards, table.remove(keyboards, 1))
    local new_layout = keyboards[1]
    awful.spawn.easy_async_with_shell(string.format("setxkbmap %s", new_layout))
end

return setmetatable({}, {
    __call = function(_, ...)
        return _M.change_kayboard_layout
    end,
})
