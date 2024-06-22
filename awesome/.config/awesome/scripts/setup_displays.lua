local awful = require'awful'
local naughty = require'naughty'
local HOME = os.getenv('HOME')
local _M = {}

function _M.setup_displays()
    awful.spawn.with_line_callback(string.format("%s/.local/scripts/setup-display -a", HOME), {
        stdout = function(line)
            naughty.notify { text = "LINE:"..line }
        end,
        stderr = function(line)
            naughty.notify { text = "ERR:"..line}
        end,
    })
end

return setmetatable({}, { __call = function(_, ...) return _M.setup_displays end })
