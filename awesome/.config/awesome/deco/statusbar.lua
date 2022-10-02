-- Standard awesome library
local gears = require'gears'
local awful = require'awful'

-- Wibox handling library
local wibox = require'wibox'

local theme = require'theme.theme'
local lain = require'lain'
local deco = {
    wallpaper = require'deco.wallpaper',
    taglist = require'deco.taglist',
    tasklist  = require'deco.tasklist'
}
local widgets = {
    audio = require'widgets.audio',
    battery = require'widgets.battery',
    capslock = require'widgets.capslock',
    network = require'widgets.network'
}

local taglist_buttons = deco.taglist()
local tasklist_buttons = deco.tasklist()

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Wibar

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)
    ))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {
            shape_border_width = 1,
            shape_border_color = '#777777',
            shape  = gears.shape.rounded_rect,
        },
        layout = {
            spacing_widget = {
                {
                    forced_width  = 5,
                    forced_height = 24,
                    thickness     = 1,
                    color         = '#777777',
                    widget        = wibox.widget.separator
                },
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            spacing = 12,
            layout  = wibox.layout.fixed.horizontal
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                wibox.widget.base.make_widget(),
                forced_height = 5,
                id            = 'background_role',
                widget        = wibox.container.background,
            },
            {
                {
                    id     = 'clienticon',
                    widget = awful.widget.clienticon,
                },
                margins = 2,
                widget  = wibox.container.margin
            },
            nil,
            create_callback = function(self, c, index, objects) --luacheck: no unused args
                self:get_children_by_id('clienticon')[1].client = c
            end,
            layout = wibox.layout.align.vertical,
        },
    }

    s.mysystray = wibox.widget.systray()

    s.mem = lain.widget.mem {
        settings = function()
            widget:set_markup(" " .. mem_now.used)
        end
    }

    s.cpu = lain.widget.cpu {
        settings = function()
            widget:set_markup(" " .. cpu_now.usage .. "%")
        end
    }

    s.clock = wibox.widget.textclock()

    s.separator = wibox.widget.separator {
        color = "#fff",
        thickness = 1,
        orientation = "vertical",
        span_ratio = 0.8,
        forced_width = 20
    }

    -- Create the wibox
    s.mywibar = awful.wibar({
        position = 'bottom',
        screen = s,
        bg = "#12131b44",
        fg = "#b5bee7"
    })

    -- Add widgets to the wibox
    s.mywibar:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            RC.launcher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            widgets.capslock,
            s.mysystray,
            s.separator,
            s.mem,
            s.separator,
            s.cpu,
            s.separator,
            widgets.network,
            s.separator,
            widgets.audio,
            s.separator,
            widgets.battery,
            s.separator,
            mykeyboardlayout,
            s.separator,
            s.clock,
            s.separator,
            s.mylayoutbox,
        },
    }
end)
-- }}}
