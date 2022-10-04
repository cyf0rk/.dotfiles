local awful = require'awful'
local wibox = require'wibox'
local theme = require'theme.theme'
local naughty = require'naughty'

local audio = wibox.widget {
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox,
    width = 60
}

audio.muted = "婢"
audio.speaker = " "

function audio:check_audio()
    awful.spawn.with_line_callback(
        "wpctl get-volume @DEFAULT_SINK@",
        {
            stdout = function (line)
                if line:match("Volume") then
                    local muted_status = line:match("Volume:%s+%d+.%d+%s+[(MUTED)]")
                    local volume_status = line:match("Volume:%s+(%d+.%d+)")

                    if line:match("MUTED") then
                        self.markup = "<span color='" .. theme.color.red .. "'>" .. self.muted .."</span>"
                        self.width = 40
                    else
                        self.markup = "<span color='" .. theme.color.blue .. "'>" .. self.speaker .."</span>" .. math.floor(volume_status * 100 + 0.5) .. "%"
                    end
                end
            end
        }
    )
end

audio:check_audio()

audio:connect_signal('button::press', function ()
    awful.spawn.easy_async_with_shell("wpctl set-mute @DEFAULT_SINK@ toggle", function ()
        audio:check_audio()
    end)
end)

return audio
