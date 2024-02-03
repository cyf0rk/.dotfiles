local awful = require'awful'

function spawn_once(command, class, tag)
    -- create move callback
    local callback
    callback = function(c)
        if c.class == class then
            awful.client.movetotag(tag, c)
            client.remove_signal("manage", callback)
        end
    end
    client.add_signal("manage", callback)
    -- now check if not already running!
    local findme = command
    local firstspace = findme:find(" ")
    if firstspace then
        findme = findme:sub(0, firstspace-1)
    end
    -- finally run it
    awful.spawn.with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || exec " .. command)
end

-- use the spawn_once
spawn_once("brave-browser", "Brave-browser")
spawn_once("wezterm-gui", "wezterm")
-- for some reason, firefox doesn't work with spawn_once
-- would need to investigate further
awful.spawn.single_instance("firefox", awful.rules.rules)
