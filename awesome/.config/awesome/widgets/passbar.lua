local awful = require'awful'
local naughty = require'naughty'
local common = require'awful.widget.common'
local theme = require'beautiful'
local gcolor = require'gears.color'
local gmath = require'gears.math'
local gstring = require'gears.string'
local wibox = require'wibox'

local passbar = {}
local instance = nil

local function colortext(str, c)
    return ("<span color='%s'>%s</span>"):format(gcolor.ensure_pango_color(c), str)
end

local function themeget(key)
    return theme['passbar_' .. key] or theme['menubar_' .. key] or theme['menu_' .. key] or theme[key]
end

local function colors(style)
    local s = style or 'normal'
    return themeget('fg_' .. s), themeget('bg_' .. s)
end

local function label(o)
    local fg, bg = colors(o.focused and 'focus' or 'normal')
    return colortext(gstring.xml_escape(o.name), fg), bg, nil, nil
end

-- we want case-insensitive fuzzy matching, but string.gmatch doesn't have that
-- so we construct it ourselves: "hello" turns into "[hH].*[eE].*[lL].*[lL].*[oO]"
local function fuzzify(query)
    local sets = {}
    for c in query:gmatch(".") do
        table.insert(sets, "[" .. c:lower() .. c:upper() .. "]")
    end
    return table.concat(sets, ".*")
end

local function update(raw_query)
    local query = (raw_query or ''):lower()
    if query ~= instance.query then
        instance.query = query
        local fuzzed_query = fuzzify(query)

        instance.shown = {}
        for _, passname in ipairs(instance.passnames) do
            if passname:match(fuzzed_query) then
                table.insert(instance.shown, { name = passname })
            end
            if passname:lower() == query then
                instance.current = #instance.shown
            end
        end
    end

    if #instance.shown > 0 then
        if instance.current > #instance.shown then
            instance.current = #instance.shown
        end
        instance.shown[instance.current].focused = true
    end

    common.list_update(
        instance.widget,
        nil,
        label,
        {},
        instance.shown
    )
end

local function cache_pass_options()
    instance.passnames = {}
    local cmd =
        "find \"${PASSWORD_STORE_DIR:-$HOME/.password-store}\" -type f -name '*.gpg' -printf '%P\\n' | " ..
        "sort -f | " ..
        "sed 's/\\.gpg$//g'"


    ret = awful.spawn.easy_async_with_shell(cmd, function(out)
        for passname in out:gmatch("[^\n]+") do
            table.insert(instance.passnames, passname)
        end
        update()
    end)
end

local function wrap_index(n, max)
    -- compensate for 1-indexing
    return (n-1) % max + 1
end

local function gen_on_keypress(type_input)
  return function(mod, key)
      if key == "Left" or (mod.Shift and key == "Tab") then
          instance.shown[instance.current].focused = false
          instance.current = wrap_index(instance.current - 1, #instance.shown)
          return true
      elseif key == "Right" or key == "Tab" then
          instance.shown[instance.current].focused = false
          instance.current = wrap_index(instance.current + 1, #instance.shown)
          return true
      elseif key == "Return" or key == "KP_Enter" then
          if instance.current <= #instance.shown then
              pass = instance.shown[instance.current].name
              if type_input then
                cmd = "pass " .. pass .. " | head -n1"
                awful.spawn.easy_async_with_shell(cmd, function(password)
                  cmd = "pass " .. pass .. " | grep -i username: | sed -e 's/^username: \\?//I'"
                  awful.spawn.easy_async_with_shell(cmd, function(username)
                    cmd = "xdotool type '" .. username:sub(1, -2) .. '	' .. password:sub(1, -2) .. "'"
                    awful.spawn.easy_async(cmd, function()end)
                  end)
                end)
              else
                awful.spawn("pass -c " .. instance.shown[instance.current].name)
              end
          end
      end
      return false
  end
end

function passbar.show(type_input)
    scr = screen[awful.screen.focused() or 1]
    local fg_color, bg_color = colors()
    local border_width = themeget('border_width') or 0
    local border_color = themeget('border_color')

    if not instance then
        instance = {
            wibox = wibox{
                ontop = true,
                bg = bg_color,
                fg = fg_color,
                border_width = border_width,
                border_color = border_color,
            },
            widget = wibox.widget {
                spacing = 5,
                layout = wibox.layout.fixed.horizontal
            },
            prompt = awful.widget.prompt(),
            query = nil,
            count_table = nil,
        }
        local layout = wibox.layout.fixed.horizontal()
        local spaced_prompt = wibox.container.constraint(
            wibox.container.margin(instance.prompt, 0, 5),
            "min",
            150
        )
        layout:add(spaced_prompt)
        layout:add(instance.widget)
        instance.wibox:set_widget(layout)
    end

    if instance.wibox.visible then
        return
    end

    local scrgeom = scr.workarea
    instance.geometry = {
        x = scrgeom.x,
        y = scrgeom.y,
        height = gmath.round(theme.get_font_height() * 1.5),
        width = scrgeom.width - border_width * 2
    }
    instance.wibox:geometry(instance.geometry)

    instance.current = 1
    cache_pass_options()

    local prompt_args = {
        prompt              = " Search: ",
        textbox             = instance.prompt.widget,
        done_callback       = passbar.hide,
        changed_callback    = update,
        keypressed_callback = gen_on_keypress(type_input)
    }

    awful.prompt.run(prompt_args)

    instance.wibox.visible = true
end

function passbar.hide()
    if instance then
        instance.wibox.visible = false
    end
end

return passbar
