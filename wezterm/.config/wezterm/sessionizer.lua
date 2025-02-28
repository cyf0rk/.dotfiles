local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

local fd = "/bin/fdfind"
local rootPath = os.getenv("HOME")

M.open = function(window, pane, find_git)
    local projects = {}

    local success, stdout, stderr = wezterm.run_child_process({
        fd,
        "-HI",
        "-td",
        "--prune",
        find_git and "--glob" or ".",
        find_git and ".git" or ".",
        "--max-depth=" .. (find_git and 4 or 1),
        rootPath,
        -- add more paths here
        rootPath .. "/work",
        rootPath .. "/work/go",
        rootPath .. "/work/typescript",
        rootPath .. "/work/javascript",
        rootPath .. "/work/python",
    })

    if not success then
        wezterm.log_error("Failed to run fd: " .. stderr)
        return
    end

    for line in stdout:gmatch("([^\n]*)\n?") do
        local project = line:gsub("/.git/?$", "") -- Handle both /.git and /.git/ paths
        local id = project:match(".*/(.*)") -- Extract last directory name
        table.insert(projects, {
            label = tostring(project:gsub(os.getenv("HOME") .. "/", "")), -- Shorter display path
            id = tostring(id),
        })
    end

    window:perform_action(
        act.InputSelector({
            action = wezterm.action_callback(function(win, _, id, label)
                if not id and not label then
                    wezterm.log_info("Cancelled")
                else
                    wezterm.log_info("Selected " .. label)
                    win:perform_action(
                        act.SwitchToWorkspace({
                            name = id,
                            spawn = { cwd = label },
                        }),
                        pane
                    )
                end
            end),
            fuzzy = true,
            title = "Select project",
            choices = projects,
        }),
        pane
    )
end

return M
