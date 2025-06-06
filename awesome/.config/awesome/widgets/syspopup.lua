-------------------------------------------------
-- Logout widget for Awesome Window Manager
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/logout-widget

-- @author Pavel Makhov
-- @copyright 2020 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local capi = {keygrabber = keygrabber }
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local buttons = require("widgets.buttons")
local gfs = require("gears.filesystem")

local WIDGET_DIR = gfs.get_configuration_dir() .. "widgets/syspopup"

local w = wibox {
    bg = beautiful.fg_normal,
    max_widget_size = 500,
    ontop = true,
    height = 200,
    width = 400,
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 8)
    end
}

local action = wibox.widget {
    text = ' ',
    widget = wibox.widget.textbox
}

local phrase_widget = wibox.widget{
    align  = 'center',
    widget = wibox.widget.textbox
}

local function create_button(icon_name, action_name, accent_color, label_color, onclick, icon_size, icon_margin)

    local button = buttons.with_icon {
        type = 'basic',
        icon = icon_name,
        color = accent_color,
        icon_size = icon_size,
        icon_margin = icon_margin,
        onclick = function()
            onclick()
            w.visible = false
            capi.keygrabber.stop()
        end
    }
    button:connect_signal("mouse::enter", function()
            action:set_markup('<span color="' .. label_color .. '">' .. action_name .. '</span>')
        end)

    button:connect_signal("mouse::leave", function() action:set_markup('<span> </span>') end)

    return button
end

local function launch(args)
    args = args or {}

    local bg_color = args.bg_color or beautiful.bg_normal
    local accent_color = args.accent_color or beautiful.bg_focus
    local text_color = args.text_color or beautiful.fg_normal
    local label_color = args.label_color or beautiful.fg_focus
    local phrases = args.phrases or {'またね'}
    local icon_size = args.icon_size or 40
    local icon_margin = args.icon_margin or 16
    local hide_on_leave = args.hide_on_leave or false

    local onlogout = args.onlogout or function () awesome.quit() end
    local onlock = args.onlock or function() awful.spawn.with_shell("xscreensaver-command -lock") end
    local onreboot = args.onreboot or function() awful.spawn.with_shell("reboot") end
    local onsuspend = args.onsuspend or function() awful.spawn.with_shell("systemctl suspend") end
    local onpoweroff = args.onpoweroff or function() awful.spawn.with_shell("shutdown now") end

    local onlogout_key = args.onlogout_key or 'l'
    local onlock_key = args.onlock_key or 'k'
    local onreboot_key = args.onreboot_key or 'r'
    local onsuspend_key = args.onsuspend_key or 'u'
    local onpoweroff_key = args.onpoweroff_key or 's'
    local all_keys = onlogout_key .. onlock_key .. onreboot_key .. onsuspend_key .. onpoweroff_key

    local ignore_case = args.ignore_case or true

    w:set_bg(bg_color)
    if #phrases > 0 then
        phrase_widget:set_markup(
            '<span color="'.. text_color .. '" size="20000">' .. phrases[ math.random( #phrases ) ] .. '</span>')
    end

    w:setup {
        {
            phrase_widget,
            {
                {
                    create_button('log-out', 'Log Out (' .. onlogout_key .. ')',
                        accent_color, label_color, onlogout, icon_size, icon_margin),
                    create_button('lock', 'Lock (' .. onlock_key .. ')',
                        accent_color, label_color, onlock, icon_size, icon_margin),
                    create_button('refresh-cw', 'Reboot (' .. onreboot_key .. ')',
                        accent_color, label_color, onreboot, icon_size, icon_margin),
                    create_button('moon', 'Suspend (' .. onsuspend_key .. ')',
                        accent_color, label_color, onsuspend, icon_size, icon_margin),
                    create_button('power', 'Power Off (' .. onpoweroff_key .. ')',
                        accent_color, label_color, onpoweroff, icon_size, icon_margin),
                    id = 'buttons',
                    spacing = 8,
                    layout = wibox.layout.fixed.horizontal
                },
                valign = 'center',
                layout = wibox.container.place
            },
            {
                action,
                halign = 'center',
                layout = wibox.container.place
            },
            spacing = 32,
            layout = wibox.layout.fixed.vertical
        },
        id = 'a',
        shape_border_width = 1,
        valign = 'center',
        layout = wibox.container.place
    }

    w.screen = mouse.screen
    w.visible = true
    if hide_on_leave then
        w:connect_signal("mouse::leave", function()
            phrase_widget:set_text('')
            capi.keygrabber.stop()
            w.visible = false
        end)
    end

    awful.placement.centered(w)
    capi.keygrabber.run(function(_, key, event)
        if event == "release" then return end
        if key then
            if key == 'Escape' then
                phrase_widget:set_text('')
                capi.keygrabber.stop()
                w.visible = false
            else
                if ignore_case then
                    key = string.lower(key)
                    onlogout_key = string.lower(onlogout_key)
                    onlock_key = string.lower(onlock_key)
                    onreboot_key = string.lower(onreboot_key)
                    onsuspend_key = string.lower(onsuspend_key)
                    onpoweroff_key = string.lower(onpoweroff_key)
                    all_keys = string.lower(all_keys)
                end

                if key == onpoweroff_key then onpoweroff()
                elseif key == onreboot_key then onreboot()
                elseif key == onsuspend_key then onsuspend()
                elseif key == onlock_key then onlock()
                elseif key == onlogout_key then onlogout()
                end

                if string.match(all_keys, key) then
                    phrase_widget:set_text('')
                    capi.keygrabber.stop()
                    w.visible = false
                end
            end
        end
    end)
end

local function widget(args)
    local icon = args.icon or WIDGET_DIR .. '/buttons/icons/power.svg'

    local res = wibox.widget {
        {
            {
                image = icon,
                widget = wibox.widget.imagebox
            },
            margins = 4,
            layout = wibox.container.margin
        },
        layout = wibox.layout.fixed.horizontal,
    }

    res:buttons(
        awful.util.table.join(
            awful.button({}, 1, function()
                if w.visible then
                    phrase_widget:set_text('')
                    capi.keygrabber.stop()
                    w.visible = false
                else
                    launch(args)
                end
            end)
        ))

    return res

end

return {
    launch = launch,
    widget = widget
}
