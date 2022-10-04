local awful = require'awful'
local lain = require'lain'
local theme = require'theme'
local dpi = require'beautiful.xresources'.apply_dpi
local gears = require'gears'
local wibox = require'wibox'

local batbar = wibox.widget {
    forced_height = dpi(1),
    forced_width = dpi(36),
    color = theme.color.fg,
    background_color = theme.color.bg,
    margins = 2,
    paddings = 2,
    ticks = true,
    ticks_size = dpi(4),
    shape = gears.shape.rounded_bar,
    widget = wibox.widget.progressbar
}

local bat_status_t = awful.tooltip {
    objects = { batbar }
}

local batupd = lain.widget.bat({
    settings = function()
        if (not bat_now.status) or bat_now.status == "N/A" or type(bat_now.perc) ~= "number" then return end

        if bat_now.status == "Charging" then
            if bat_now.perc >= 98 then
                batbar:set_color(theme.color.green)
            else
                batbar:set_color(theme.color.aqua)
            end
        else
            if bat_now.perc >= 88 then
                batbar:set_color(theme.color.green)
            elseif bat_now.perc > 35 then
                batbar:set_color(theme.color.fg)
            elseif bat_now.perc > 15 then
                batbar:set_color(theme.color.orange)
            else
                batbar:set_color(theme.color.red)
            end
        end
        batbar:set_value(bat_now.perc / 100)
    end
})

batbar:connect_signal('mouse::enter', function ()
    bat_status_t:set_text(bat_now.perc .. "%")
end)

local batbg = wibox.container.background(batbar, theme.color.darkgray, gears.shape.rounded_rect)
local batwidget = wibox.container.margin(batbg, dpi(2), dpi(2), dpi(4), dpi(4))

return batwidget
