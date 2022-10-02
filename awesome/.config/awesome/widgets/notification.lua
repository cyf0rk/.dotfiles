local naughty = require'naughty'

-- Changing spotify notifications.
naughty.config.presets.spotify = {
    -- if you want to disable Spotify notifications completely, return false
    callback = function(args)
        return true
    end,

    height = 50,
    width  = 300,
    icon_size = 40
}
table.insert(naughty.dbus.config.mapping, {{appname = "Spotify"}, naughty.config.presets.spotify})
