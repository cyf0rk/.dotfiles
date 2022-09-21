-- WezTerm configuration
---------------------------------------------------------------

local config_misc = {
    color_scheme = 'tokyonight',
    dpi = 226,
    tab_bar_at_bottom = true,

    window_close_confirmation = 'NeverPrompt',
    check_for_updates = false,

    -- Avoid unexpected config breakage and unusable terminal
    automatically_reload_config = false,

    -- Make sure word selection stops on most punctuations.
    --
    -- Note that dot (.) & slash (/) are allowed though for
    -- easy selection of (partial) paths.
    selection_word_boundary = " \t\n{}[]()\''`,;:@│*",

    -- Do not hold on exit by default.
    -- Because the default 'CloseOnCleanExit' can be annoying when exiting with
    -- Ctrl-D and the last command exited with non-zero: the shell will exit
    -- with non-zero and the terminal would hang until the window is closed manually.
    exit_behavior = 'Close', -- NOTE: this is now the default, remove?
}

-- Merge configs and return!
------------------------------------------

local mytable = require'lib/stdlib'.mytable
local full_config = mytable.merge_all(
    config_misc,
    require'appearance',
    require'fonts',
    require'keys',
    require'mouse',
    {} -- so the last table can have an ending comma for git diffs :)
)

return full_config
