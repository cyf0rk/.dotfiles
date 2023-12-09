local wezterm = require 'wezterm'
local mux = wezterm.mux

-- Decide whether cmd represents a default startup invocation
function is_default_startup(cmd)
  if not cmd then
    -- we were started with `wezterm` or `wezterm start` with
    -- no other arguments
    return true
  end
  if cmd.domain == "DefaultDomain" and not cmd.args then
    -- Launched via `wezterm start --cwd something`
    return true
  end
  -- we were launched some other way
  return false
end

wezterm.on('gui-startup', function(cmd)
  if is_default_startup(cmd) then
    -- for the default startup case, we want to switch to the unix domain instead
    local unix = mux.get_domain("unix")
    mux.set_default_domain(unix)
    -- ensure that it is attached
    unix:attach()
  end
end)

-- WezTerm configuration
---------------------------------------------------------------

local config_misc = {
    window_close_confirmation = 'NeverPrompt',
    check_for_updates = false,

    -- Avoid unexpected config breakage and unusable terminal
    automatically_reload_config = false,

    -- Make sure word selection stops on most punctuations.
    --
    -- Note that dot (.) & slash (/) are allowed though for
    -- easy selection of (partial) paths.
    selection_word_boundary = " \t\n{}[]()\''`,;:@│*",

    unix_domains = {
      { name = "unix" }
    },

    default_gui_startup_args = { 'connect', 'unix' },
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
