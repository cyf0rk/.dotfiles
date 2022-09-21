local wezterm = require'wezterm'

local config = {}

-- Disable annoying default behaviors
config.adjust_window_size_when_changing_font_size = false
-- that one was opening a separate win on first unknown glyph, stealing windows focus (!!)
config.warn_about_missing_glyphs = false

config.font_size = 14.0

-- Makes FontAwesome's double-width glyphs display properly!
config.allow_square_glyphs_to_overflow_width = 'WhenFollowedBySpace'

-- Additional font directory (necessary to find FontAwesome font!)
config.font_dirs = {'fonts'} -- relative to main config file

local function font_with_fallback(font_family)
    -- family names, not file names
    return wezterm.font_with_fallback({
        font_family,
        'Font Awesome 6 Free Solid', -- nice double-spaced symbols!
    })
end

local function font_and_rules_for_jetbrains()
    -- Use a _very slightly_ lighter variant, so that regular bold really stand out
    local font = font_with_fallback('JetBrains Mono Light')
    local font_rules = {
        {
            italic = true,
            font = font_with_fallback('JetBrains Mono Light Italic'),
        },
        {
            italic = true, intensity = 'Bold',
            font = font_with_fallback('JetBrains Mono Bold Italic'),
        },
        {
            intensity = 'Bold',
            font = font_with_fallback('JetBrains Mono Bold'),
        },
    }
    return font, font_rules
end

local function font_and_rules_for_firacode()
    local font = font_with_fallback('FiraCode Nerd Font Mono')
    local font_rules = {
        {
            italic = true,
            font = wezterm.font('FiraCode Nerd Font Mono', { italic = true })
        },
    }
    return font, font_rules
end

-- FIXME (<- this is an example of bolded text)
-- 0 1 2 3 4 5 6 7 8 9
-- Some ligatures: != <-> <-  -> ----> => ==> ===> -- --- /../;;/ #{}
--  <> <!-- --> ->> --> <= >= ++ == === := a::b::c a&&b a||b

config.font, config.font_rules = font_and_rules_for_firacode()

-- Enable various OpenType features
-- See https://docs.microsoft.com/en-us/typography/opentype/spec/featurelist
config.harfbuzz_features = {
    'zero', -- Use a slashed zero '0' (instead of dotted)
    'kern', -- (default) provide optically consistent spacing between glyphs
    'liga', -- (default) ligatures
    'clig', -- (default) contextual ligatures
}

return config
