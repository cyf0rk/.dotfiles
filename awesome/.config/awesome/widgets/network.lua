local awful = require'awful'
local wibox = require'wibox'
local theme = require'theme'

local eth = wibox.widget {
  widget = wibox.widget.textbox,
  align = "center",
  valign = "center",
  forced_width = 25,
  markup = "",
}

eth.connected = ""
eth.disconnected = ""

local wifi = wibox.widget {
  widget = wibox.widget.textbox,
  align = "center",
  valign = "center",
  forced_width = 25,
  markup = "睊"
}

wifi.connected = "直"
wifi.disconnected = "睊"

local tooltip = awful.tooltip({})

tooltip:add_to_object(capslock)

local network = wibox.widget {
    eth,
    wifi,
    layout = wibox.layout.fixed.horizontal
}

function network:check()
  awful.spawn.with_line_callback(
    "bash -c 'ip link show'",
    {
      stdout = function (line)
        if line:match("%d+:%s+(en%g+):%s.*") then
            local status = line:gsub(".*(enx%g+:%s.*state%s)(%a+).*", "%2")
                tooltip.text = "Ethernet connection: " .. status
            if status == "UP" then
                eth.markup = "<span color='" .. theme.color.blue .. "'>" .. eth.connected .."</span>"
            else
                eth.markup = "<span color='" .. theme.color.red .. "'>" .. eth.disconnected .."</span>"
            end
        end
        if line:match("%d+:%s+(wl%g+):%s.*") then
          local status = line:gsub(".*(wl%g+:%s.*state%s)(%a+).*", "%2")
          tooltip.text = "Wireless connection: " .. status
          if status == "UP" then
            wifi.markup = "<span color='" .. theme.color.blue .. "'>" .. wifi.connected .."</span>"
          else
            wifi.markup = "<span color='" .. theme.color.red .. "'>" .. wifi.disconnected .."</span>"
          end
        end
      end
    }
  )
end

network:check()

return network
