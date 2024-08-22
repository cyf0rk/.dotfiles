local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gears = require("gears")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local color = require("theme.color")
local shape = require("theme.shape")

local theme = {}

theme.font = "Ubuntu Nerd Font 11"
theme.wallpaper = RC.vars.wallpaper

theme.bg_normal = color.bg
theme.bg_focus = color.blue
theme.bg_urgent = color.red
theme.bg_minimize = color.dark_gray
theme.bg_systray = theme.bg_normal

theme.fg_normal = color.fg
theme.fg_focus = color.bg
theme.fg_urgent = color.fg
theme.fg_minimize = color.gray

theme.useless_gap = dpi(4)
theme.gap_single_client = true
theme.border_width = dpi(1)
theme.border_normal = color.dark_gray
theme.border_focus = color.blue
theme.border_marked = color.gray

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

theme.prompt_fg = color.fg
theme.prompt_bg = color.full_transparency
theme.prompt_fg_cursor = color.full_transparency
theme.prompt_bg_cursor = color.blue

-- Generate taglist squares:
theme.taglist_fg_focus = color.bg
theme.taglist_bg_focus = color.blue
theme.taglist_fg_urgent = color.fg
theme.taglist_bg_urgent = color.red
theme.taglist_fg_occupied = color.fg
theme.taglist_bg_occupied = color.dark_gray
theme.taglist_fg_empty = color.blue
theme.taglist_bg_empty = color.bg
theme.taglist_shape = shape.rounded_shape
theme.taglist_disable_icon = true
theme.taglist_spacing = 4
theme.taglist_squares_sel = ""
theme.taglist_squares_unsel = ""

theme.tasklist_bg_normal = color.bg
theme.tasklist_bg_focus = color.dark_gray
theme.tasklist_bg_urgent = color.dark_gray
theme.tasklist_shape_border_color_urgent = color.red

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
theme.snap_bg = color.blue
theme.snap_border_width = 3
theme.snapper_gap = 4
theme.tooltip_fg = color.fg
theme.tooltip_bg = color.bg_transparent
theme.notification_fg = color.fg
theme.notification_bg = color.bg
theme.notification_border_width = 3
theme.notification_border_color = color.dark_gray
theme.notification_shape = shape.rounded_shape

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
-- theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width = dpi(200)
theme.menu_border_color = color.dark_gray
theme.menu_border_width = 3
theme.menu_fg_focus = color.bg
theme.menu_bg_focus = color.blue
theme.menu_fg_normal = color.fg
theme.menu_bg_normal = color.bg_transparent

theme.menubar_fg_normal = color.fg
theme.menubar_bg_normal = color.bg_transparent
theme.menubar_border_width = 1
theme.menubar_border_color = color.blue
theme.menubar_fg_focus = color.bg
theme.menubar_bg_focus = color.blue

theme.hotkeys_fg = color.fg
theme.hotkeys_bg = color.bg
theme.hotkeys_group_margin = 20
theme.hotkeys_label_fg = color.bg
theme.hotkeys_modifiers_fg = color.blue
theme.hotkeys_shape = shape.rounded_shape
theme.hotkeys_border_color = color.dark_gray
theme.hotkeys_border_width = 3

theme.wibar_height = 20
theme.wibar_shape = shape.rounded_shape
theme.wibar_margins = 4
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path
    .. "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = themes_path
    .. "default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path
    .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = themes_path
    .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path
    .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themes_path
    .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path
    .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path
    .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path
    .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path
    .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path
    .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path
    .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path
    .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path
    .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path
    .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path
    .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path
    .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = themes_path
    .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path
    .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = themes_path
    .. "default/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh = gears.color.recolor_image(
    themes_path .. "default/layouts/fairhw.png",
    color.blue
)
theme.layout_fairv = gears.color.recolor_image(
    themes_path .. "default/layouts/fairvw.png",
    color.blue
)
theme.layout_floating = gears.color.recolor_image(
    themes_path .. "default/layouts/floatingw.png",
    color.blue
)
theme.layout_magnifier = gears.color.recolor_image(
    themes_path .. "default/layouts/magnifierw.png",
    color.blue
)
theme.layout_max = gears.color.recolor_image(
    themes_path .. "default/layouts/maxw.png",
    color.blue
)
theme.layout_fullscreen = gears.color.recolor_image(
    themes_path .. "default/layouts/fullscreenw.png",
    color.blue
)
theme.layout_tilebottom = gears.color.recolor_image(
    themes_path .. "default/layouts/tilebottomw.png",
    color.blue
)
theme.layout_tileleft = gears.color.recolor_image(
    themes_path .. "default/layouts/tileleftw.png",
    color.blue
)
theme.layout_tile = gears.color.recolor_image(
    themes_path .. "default/layouts/tilew.png",
    color.blue
)
theme.layout_tiletop = gears.color.recolor_image(
    themes_path .. "default/layouts/tiletopw.png",
    color.blue
)
theme.layout_spiral = gears.color.recolor_image(
    themes_path .. "default/layouts/spiralw.png",
    color.blue
)
theme.layout_dwindle = gears.color.recolor_image(
    themes_path .. "default/layouts/dwindlew.png",
    color.blue
)
theme.layout_cornernw = gears.color.recolor_image(
    themes_path .. "default/layouts/cornernww.png",
    color.blue
)
theme.layout_cornerne = gears.color.recolor_image(
    themes_path .. "default/layouts/cornernew.png",
    color.blue
)
theme.layout_cornersw = gears.color.recolor_image(
    themes_path .. "default/layouts/cornersww.png",
    color.blue
)
theme.layout_cornerse = gears.color.recolor_image(
    themes_path .. "default/layouts/cornersew.png",
    color.blue
)

-- Generate Awesome icon:
-- theme.awesome_icon = theme_assets.awesome_icon(
--     theme.menu_height, theme.bg_focus, theme.fg_focus
-- )

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
