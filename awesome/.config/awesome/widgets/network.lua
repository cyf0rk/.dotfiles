local awful = require'awful'
local wibox = require'wibox'
local color = require'theme.color'

local icons = {
    eth_connected = "<span color='" .. color.blue .. "'>󰈀</span>",
    eth_disconnected = "<span color='" .. color.red .. "'>󰈂</span>",
    wifi_connected = "<span color='" .. color.blue .. "'>󱚽</span>",
    wifi_disconnected = "<span color='" .. color.red .. "'>󰖪</span>"
}

local eth = wibox.widget {
  widget = wibox.widget.textbox,
  align = "center",
  valign = "center",
  forced_width = 25,
  markup = icons.eth_disconnected,
}

local wifi = wibox.widget {
  widget = wibox.widget.textbox,
  align = "center",
  valign = "center",
  forced_width = 25,
  markup = icons.wifi_disconnected
}

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
            if status == "UP" then
                eth.markup = icons.eth_connected
            else
                eth.markup = icons.eth_disconnected
            end
        end
        if line:match("%d+:%s+(wl%g+):%s.*") then
          local status = line:gsub(".*(wl%g+:%s.*state%s)(%a+).*", "%2")
          if status == "UP" then
            wifi.markup = icons.wifi_connected
          else
            wifi.markup = icons.wifi_disconnected
          end
        end
      end
    }
  )
end

network:check()

return network
