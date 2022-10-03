-- Standard awesome library
local gears = require'gears'
local awful = require'awful'
local wibox = require'wibox'
local hotkeys_popup = require'awful.hotkeys_popup'
local menubar = require'menubar'
local naughty = require'naughty'

local widgets = {
    capslock = require'widgets.capslock',
    audio = require'widgets.audio'
}

-- Resource Configuration
local modkey = RC.vars.modkey
local terminal = RC.vars.terminal

-- Scripts
local change_kayboard_layout = require'scripts.xkbmap'

local HOME = os.getenv('HOME')

local _M = {}

-- reading
-- https://awesomewm.org/wiki/Global_Keybindings

local confirmQuitmenu = awful.menu({ items = { { "Cancel", function() do end end },
    { "Quit wm", function() awesome.quit() end } }
})

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()
    local globalkeys = gears.table.join(
        awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
            {description="show help", group="awesome"}),

        --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- Tag browsing
        awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
            {description = "view previous", group = "tag"}),
        awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
            {description = "view next", group = "tag"}),
        awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
            {description = "go back", group = "tag"}),

        awful.key({ modkey,           }, "j",
            function ()
                awful.client.focus.byidx( 1)
            end,
            {description = "focus next by index", group = "client"}
        ),
        awful.key({ modkey,           }, "k",
            function ()
                awful.client.focus.byidx(-1)
            end,
            {description = "focus previous by index", group = "client"}
        ),
        awful.key({ modkey,           }, "w", function () RC.mainmenu:show() end,
            {description = "show main menu", group = "awesome"}),

        --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- Layout manipulation
        awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
            {description = "swap with next client by index", group = "client"}),
        awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
            {description = "swap with previous client by index", group = "client"}),
        awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
            {description = "focus the next screen", group = "screen"}),
        awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
            {description = "focus the previous screen", group = "screen"}),
        awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
            {description = "jump to urgent client", group = "client"}),
        awful.key({ modkey,           }, "Tab",
            function ()
                awful.client.focus.history.previous()
                if client.focus then
                    client.focus:raise()
                end
            end,
            {description = "go back", group = "client"}),
        awful.key({ "Mod4", "Control" }, "p", function ()
                awful.spawn.with_line_callback(string.format("%s/.local/scripts/setup-display -a", HOME), {
                    stdout = function(line)
                        naughty.notify { text = "LINE:"..line }
                    end,
                    stderr = function(line)
                        naughty.notify { text = "ERR:"..line}
                    end,
                })
            end,
            {description = "setup display output", group = "screen"}),

        --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- Standard program
        awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
            {description = "open a terminal", group = "launcher"}),
        awful.key({ modkey, "Shift" }, "r", awesome.restart,
            {description = "reload awesome", group = "awesome"}),
        awful.key({ modkey, "Shift"   }, "e", function () confirmQuitmenu:show() end,
            {description = "quit awesome", group = "awesome"}),

        --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- Layout manipulation
        awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
            {description = "increase master width factor", group = "layout"}),
        awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
            {description = "decrease master width factor", group = "layout"}),
        awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
            {description = "increase the number of master clients", group = "layout"}),
        awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
            {description = "decrease the number of master clients", group = "layout"}),
        awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
            {description = "increase the number of columns", group = "layout"}),
        awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
            {description = "decrease the number of columns", group = "layout"}),
        awful.key({ modkey, "Shift"   }, "Right", function () awful.layout.inc( 1)                end,
            {description = "select next", group = "layout"}),
        awful.key({ modkey, "Shift"   }, "Left", function () awful.layout.inc(-1)                end,
            {description = "select previous", group = "layout"}),

        awful.key({ modkey, "Control" }, "n",
            function ()
                local c = awful.client.restore()
                -- Focus restored client
                if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                end
            end,
            {description = "restore minimized", group = "client"}),

        awful.key({ "Mod4" }, "space", change_kayboard_layout(),
            {description = "change keyboard layout", group = "layout"}),

        --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- Prompt
        awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
            {description = "run prompt", group = "launcher"}),

        awful.key({ modkey }, "x",
            function ()
                awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                }
            end,
            {description = "lua execute prompt", group = "awesome"}),

        --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- Resize
        --awful.key({ modkey, "Control" }, "Left",  function () awful.client.moveresize( 20,  20, -40, -40) end),
        --awful.key({ modkey, "Control" }, "Right", function () awful.client.moveresize(-20, -20,  40,  40) end),
        awful.key({ modkey, "Control" }, "Down",
            function () awful.client.moveresize( 0, 0, 0, -20) end),
        awful.key({ modkey, "Control" }, "Up",
            function () awful.client.moveresize( 0, 0, 0,  20) end),
        awful.key({ modkey, "Control" }, "Left",
            function () awful.client.moveresize( 0, 0, -20, 0) end),
        awful.key({ modkey, "Control" }, "Right",
            function () awful.client.moveresize( 0, 0,  20, 0) end),

        -- Move
        awful.key({ modkey, "Shift"   }, "Down",
            function () awful.client.moveresize(  0,  20,   0,   0) end),
        awful.key({ modkey, "Shift"   }, "Up",
            function () awful.client.moveresize(  0, -20,   0,   0) end),
        awful.key({ modkey, "Shift"   }, "Left",
            function () awful.client.moveresize(-20,   0,   0,   0) end),
        awful.key({ modkey, "Shift"   }, "Right",
            function () awful.client.moveresize( 20,   0,   0,   0) end),

        --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- Menubar
        awful.key({ modkey }, "d", function() menubar.show() end,
            {description = "show the menubar", group = "launcher"}),

        --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- fn keys
        awful.key({}, "XF86AudioRaiseVolume", function()
                awful.spawn.easy_async_with_shell("pactl set-sink-volume @DEFAULT_SINK@ +5%", function ()
                    widgets.audio:check_audio()
                end)
            end),
        awful.key({}, "XF86AudioLowerVolume", function()
                awful.spawn.easy_async_with_shell("pactl set-sink-volume @DEFAULT_SINK@ -5%", function ()
                    widgets.audio:check_audio()
                end)
            end),
        awful.key({}, "XF86AudioMute", function()
                awful.spawn.easy_async_with_shell("wpctl set-mute @DEFAULT_SINK@ toggle", function ()
                    widgets.audio:check_audio()
                end)
            end),
        awful.key({}, "XF86AudioMicMute", function()
                awful.spawn.easy_async_with_shell("pactl set-source-mute @DEFAULT_SOURCE@ toggle", function ()
                    widgets.audio:check_audio()
                end)
            end),
        awful.key({}, "XF86MonBrightnessUp", function()
                awful.spawn.with_shell("light -A 10")
            end),
        awful.key({}, "XF86MonBrightnessDown", function()
                awful.spawn.with_shell("light -U 10")
            end),

        --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- Additional keybindings
        awful.key({}, "Caps_Lock", function() widgets.capslock:check() end),

        awful.key({ modkey, "Shift" }, "s", function()
                awful.spawn.with_shell("flameshot gui")
            end,
            {description = "take screenshot", group = "awesome"})

    )

    return globalkeys
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
