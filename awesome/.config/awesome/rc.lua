-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
-- pcall(require, 'luarocks.loader')

-- Standard awesome library
local awful = require("awful")

-- Miscellanous awesome library
local menubar = require("menubar")

RC = {} -- global namespace, on top before require any modules
RC.vars = require("main.user-variables")

-- {{{ Error handling -- }}}
require("main.error-handling")

-- {{{ Theme
require("theme")
-- }}}

-- Custom Local Library
local main = require("main")
-- Custom Local Library: Keys and Mouse Binding
local binding = require("binding")

-- {{{ Layouts
-- Table of layouts to cover with awful.layout.inc, order matters.
-- a variable needed in main.tags, and statusbar
-- awful.layout.layouts = { ... }
RC.layouts = main.layouts()
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
-- a variable needed in rules, tasklist, and globalkeys
RC.tags = main.tags()
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
RC.mainmenu = awful.menu({ items = main.menu() }) -- in globalkeys

-- Menubar configuration
-- Set the terminal for applications that require it
menubar.utils.terminal = RC.vars.terminal
-- }}}

-- {{{ Mouse and Key bindings
RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)

-- Set root
root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the 'manage' signal).
awful.rules.rules = main.rules(binding.clientkeys(), binding.clientbuttons())

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()
-- }}}

-- {{{ Statusbar: Wibar
require("deco.statusbar")
require("deco.notification")
-- }}}

-- {{{ Signals
require("main.signals")
-- }}}
--
-- awful.autofocus is DEPRECATED, should be replaced
require("awful.autofocus")

-- {{{ Autostart apps
require("scripts.autostart")
-- }}}
