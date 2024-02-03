local wezterm = require'wezterm'
local colors = require'lua/rose-pine'.colors()
local window_frame_colors = require'lua/rose-pine'.window_frame()

local window_frame = {
    font_size = 3,
    table.unpack(window_frame_colors),
}

local config = {
    colors = colors,
    window_frame = window_frame,

    dpi = 226,
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    show_new_tab_button_in_tab_bar = false,
    tab_max_width = 16,
    -- Pad window to avoid the content to be too close to the border,
    -- so it's easier to see and select.
    window_padding = {
        left = 5, right = 5,
        top = 5, bottom = 0,
    },
    inactive_pane_hsb = {
        -- NOTE: these values are multipliers, applied on normal pane values
        saturation = 0.9,
        brightness = 0.6,
    },
    tab_bar_at_bottom = true,
}

-- NOTE: this is a workaround for changing font-size on the fly in Zen Mode for NeoVim
wezterm.on('user-var-changed', function(window, pane, name, value)
    local overrides = window:get_config_overrides() or {}
    if name == "ZEN_MODE" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while (number_value > 0) do
                window:perform_action(wezterm.action.IncreaseFontSize, pane)
                number_value = number_value - 1
            end
            overrides.enable_tab_bar = false
        elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.font_size = nil
            overrides.enable_tab_bar = true
        else
            overrides.font_size = number_value
            overrides.enable_tab_bar = false
        end
    end
    window:set_config_overrides(overrides)
end)

return config
