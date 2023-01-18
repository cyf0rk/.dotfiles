local home = os.getenv("HOME")

local _M = {
    -- This is used later as the default terminal and editor to run.
    terminal = "x-terminal-emulator",

    -- Default modkey.
    modkey = "Mod4",

    -- user defined wallpaper
    wallpaper = home .. "/.config/awesome/theme/assets/wallpaper.jpg",
}

return _M

