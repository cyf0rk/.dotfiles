---------------------------------------------------------------
-- WezTerm configuration
---------------------------------------------------------------

local config_misc = {
    window_close_confirmation = "NeverPrompt",
    check_for_updates = false,

    -- Avoid unexpected config breakage and unusable terminal
    automatically_reload_config = false,

    -- Make sure word selection stops on most punctuations.
    --
    -- Note that dot (.) & slash (/) are allowed though for
    -- easy selection of (partial) paths.
    selection_word_boundary = " \t\n{}[]()''`,;:@│*",

    unix_domains = {
        { name = "unix" },
    },

    default_gui_startup_args = { "connect", "unix" },
}

------------------------------------------
-- Merge configs and return!
------------------------------------------

local mytable = require("lib/stdlib").mytable
local full_config = mytable.merge_all(
    config_misc,
    require("appearance"),
    require("fonts"),
    require("keys"),
    require("mouse"),
    {} -- so the last table can have an ending comma for git diffs :)
)

return full_config
