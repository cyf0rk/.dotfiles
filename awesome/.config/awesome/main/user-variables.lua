local home = os.getenv("HOME")

local _M = {
    -- This is used later as the default terminal and editor to run.
    terminal = "x-terminal-emulator",

    -- Default modkey.
    modkey = "Mod1",

    -- user defined wallpaper
    wallpaper = home .. "/.config/awesome/theme/wp.jpg",
}

return _M

