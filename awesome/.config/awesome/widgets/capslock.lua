local awful = require'awful'
local wibox = require'wibox'
local color = require'theme.color'

local capslock = wibox.widget {
    widget = wibox.widget.textbox,
    align = "center",
    valign = "center",
}

capslock.activated = "<b><span color='".. color.blue .."'></span> CAPS</b>"
capslock.deactivated = ""

local tooltip = awful.tooltip({})

tooltip:add_to_object(capslock)

function capslock:check()
    awful.spawn.with_line_callback(
        "bash -c 'sleep 0.2 && xset q'",
        {
            stdout = function (line)
                if line:match("Caps Lock") then
                    local status = line:gsub(".*(Caps Lock:%s+)(%a+).*", "%2")
                    tooltip.text = "Caps Lock " .. status
                    if status == "on" then
                        self.markup = self.activated
                        self.forced_width = 70
                    else
                        self.markup = self.deactivated
                        self.forced_width = 0
                    end
                end
            end
        }
    )
end

capslock:check()

return capslock
