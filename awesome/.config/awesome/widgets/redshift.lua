local async = require("lain.helpers").async
local awful = require("awful")
local execute = os.execute
local type = type

-- Redshift
-- lain.widget.contrib.redshift
local redshift = { active = false, pid = nil }

function redshift.start()
    execute("pkill redshift")
    awful.spawn.with_shell("redshift -x") -- clear adjustments
    redshift.pid = awful.spawn.with_shell("redshift")
    redshift.active = true
    if type(redshift.update_fun) == "function" then
        redshift.update_fun(redshift.active)
    end
end

function redshift.toggle()
    local check_cmd = redshift.pid
            and string.format("ps -p %d -o pid=", redshift.pid)
        or "pgrep redshift"

    async({ awful.util.shell, "-c", check_cmd }, function(f)
        -- Rest remains unchanged
        if f and #f > 0 then
            execute("pkill -USR1 redshift")
            redshift.active = not redshift.active
        else
            redshift.start()
        end
        redshift.update_fun(redshift.active)
    end)
end

-- Attach to a widget
-- Provides a button which toggles redshift on/off on click
-- @param widget:  Widget to attach to.
-- @param fun:     Function to be run each time redshift is toggled (optional).
--                 Use it to update widget text or icons on status change.
function redshift.attach(widget, fun)
    redshift.update_fun = fun or function() end
    if not redshift.pid then
        redshift.start()
    end
    if widget then
        widget:buttons(awful.util.table.join(awful.button({}, 1, function()
            redshift.toggle()
        end)))
    end
end

return redshift
