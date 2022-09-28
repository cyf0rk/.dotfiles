local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local HOME = os.getenv('HOME')
local ICON_DIR = HOME .. '/Pictures/'

local power_menu = wibox.widget {
    -- 
    {
        image = ICON_DIR .. 'bookmark.svg',
        resize = true,
        widget = wibox.widget.imagebox,
    },
    margins = 4,
    widget = wibox.container.margin
}

-- code mentioned below goes here

return power_menu
