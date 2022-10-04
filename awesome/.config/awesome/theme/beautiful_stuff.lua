local beautiful = require'beautiful'
local gears = require'gears'
local color = require'theme.color'

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.font = "FiraCode Nerd Font Mono"
beautiful.useless_gap = 4
beautiful.gap_single_client = true
beautiful.wallpaper = RC.vars.wallpaper
beautiful.taglist_fg_focus = color.bg
beautiful.taglist_bg_focus = color.blue
beautiful.taglist_fg_urgent = color.fg
beautiful.taglist_bg_urgent = color.red
beautiful.taglist_fg_occupied = color.fg
beautiful.taglist_bg_occupied = color.darkgray
beautiful.taglist_fg_empty = color.blue
beautiful.taglist_bg_empty = color.bg
beautiful.taglist_shape = gears.shape.octogon
beautiful.taglist_disable_icon = true
beautiful.taglist_spacing = 4
beautiful.taglist_squares_sel = ""
beautiful.taglist_squares_unsel = ""
beautiful.tasklist_bg_normal = color.bg
beautiful.tasklist_bg_focus = color.darkgray
beautiful.tasklist_bg_urgent = color.darkgray
beautiful.tasklist_shape_border_color_urgent = color.red
