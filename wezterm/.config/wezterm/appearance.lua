local config = {}

config.hide_tab_bar_if_only_one_tab = true

-- Pad window to avoid the content to be too close to the border,
-- so it's easier to see and select.
config.window_padding = {
    left = 3, right = 3,
    top = 3, bottom = 3,
}

config.inactive_pane_hsb = {
    -- NOTE: these values are multipliers, applied on normal pane values
    saturation = 0.9,
    brightness = 0.6,
}

return config
