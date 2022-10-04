local beautiful = require'beautiful'
local gears = require'gears'
local theme = require'theme'

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.font = theme.font
beautiful.useless_gap = 4
beautiful.gap_single_client = true
beautiful.wallpaper = RC.vars.wallpaper
beautiful.taglist_fg_focus = theme.color.bg
beautiful.taglist_bg_focus = theme.color.blue
beautiful.taglist_fg_urgent = theme.color.fg
beautiful.taglist_bg_urgent = theme.color.red
beautiful.taglist_fg_occupied = theme.color.fg
beautiful.taglist_bg_occupied = theme.color.darkgray
beautiful.taglist_fg_empty = theme.color.blue
beautiful.taglist_bg_empty = theme.color.bg
beautiful.taglist_shape = theme.rounded_shape
beautiful.taglist_disable_icon = true
beautiful.taglist_spacing = 4
beautiful.taglist_squares_sel = ""
beautiful.taglist_squares_unsel = ""
beautiful.tasklist_bg_normal = theme.color.bg
beautiful.tasklist_bg_focus = theme.color.darkgray
beautiful.tasklist_bg_urgent = theme.color.darkgray
beautiful.tasklist_shape_border_color_urgent = theme.color.red
