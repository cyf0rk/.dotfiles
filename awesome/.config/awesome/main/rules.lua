-- Standard awesome library
local awful     = require'awful'
-- Theme handling library
local beautiful = require'beautiful'

local _M = {}

-- reading
-- https://awesomewm.org/apidoc/libraries/awful.rules.html

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get(clientkeys, clientbuttons)
    local rules = {
        -- All clients will match this rule.
        {
            rule = { },
            properties = {
                border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                focus     = awful.client.focus.filter,
                raise     = true,
                keys      = clientkeys,
                buttons   = clientbuttons,
                screen    = awful.screen.preferred,
                placement = awful.placement.no_overlap+awful.placement.no_offscreen
            }
        },

        -- Floating clients.
        {
            rule_any = {
                instance = {
                    "DTA",  -- Firefox addon DownThemAll.
                    "copyq",  -- Includes session name in class.
                    "pinentry",
                },
                class = {
                    "Arandr",
                    "Blueman-manager",
                    "Gpick",
                    "Kruler",
                    "MessageWin",  -- kalarm.
                    "Sxiv",
                    "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                    "Wpa_gui",
                    "veromix",
                    "xtightvncviewer",
                    "Nautilus"
                },

                -- Note that the name property shown in xprop might be set slightly after creation of the client
                -- and the name shown there might not match defined rules here.
                name = {
                    "Event Tester",  -- xev.
                },
                role = {
                    "AlarmWindow",  -- Thunderbird's calendar.
                    "ConfigManager",  -- Thunderbird's about:config.
                    "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
                }
            },
            properties = {
                floating = true
            }
        },

        -- Add titlebars to normal clients and dialogs
        {
            rule_any = {
                type = { "normal", "dialog" }
            },
            properties = {
                titlebars_enabled = false
            }
        },

        -- Map apps to different tags and screens
        -- it assumes there are only 2 screens and Primary monitor (1) is external one
        -- (set in $HOME/.local/scripts/setup-display script)
        {
            rule = { class = "Brave-browser" },
            properties = { tag = "1", screen = 1 }
        },
        {
            rule_any = { class = { "firefox" } },
            properties = { tag = "1", screen = function() return screen.count() end }
        },
        {
            rule_any = { class = { "Postman" } },
            properties = { tag = "2", screen = 1 }
        },
        {
            rule = { class = "wezterm" },
            properties = { tag = "3", screen = 1 }
        },
        {
            rule = { class = "Code" },
            properties = { tag = "4", screen = 1 }
        },
        {
            rule = { class = "DBeaver" },
            properties = { tag = "5", screen = 1 }
        },
        {
            rule = { class = "Gimp" },
            properties = { tag = "6", screen = 1 }
        },
        {
            rule_any = { class = { "discord", "Slack" } },
            properties = { tag = "8", screen = function() return screen.count() end }
        },
        {
            rule = { class = "thunderbird" },
            properties = { tag = "9", screen = function() return screen.count() end }
        },
        -- {
            -- rule = { class = "Spotify" },
            -- properties = { tag = "10", screen = function() return screen.count() end }
        -- },

    }

    return rules
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
