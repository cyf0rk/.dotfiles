local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

local fd = "/usr/local/bin/fdfind"
local rootPath = os.getenv("HOME")

M.open = function(window, pane, find_git)
    local projects = {}
    local args = {
        fd,
        "-HI",
        "-td",
        "--prune",
    }

    if find_git then
        table.insert(args, "--glob")
        table.insert(args, ".git")
    else
        table.insert(args, ".")
    end

    local paths = {
        rootPath,
        rootPath .. "/work",
        rootPath .. "/work/cloud",
        rootPath .. "/work/shopify",
        rootPath .. "/work/go",
        rootPath .. "/work/typescript",
        rootPath .. "/work/javascript",
        rootPath .. "/work/python",
        rootPath .. "/vaults",
    }

    for _, path in ipairs(paths) do
        table.insert(args, path)
    end

    local success, stdout, stderr = wezterm.run_child_process(args)

    if not success then
        wezterm.log_error("Failed to run fd: " .. stderr)
        return
    end

    for line in stdout:gmatch("([^\n]*)\n?") do
        local project = line:gsub("/.git/?$", "") -- Handle both /.git and /.git/ paths
        local id = project:match(".*/(.*)") -- Extract last directory name
        table.insert(projects, {
            label = tostring(project:gsub(rootPath .. "/", "")),
            id = tostring(id),
        })
    end

    window:perform_action(
        act.InputSelector({
            action = wezterm.action_callback(function(win, _, id, label)
                if not id and not label then
                    wezterm.log_info("Cancelled")
                else
                    local full_path = (id and id ~= "") and id
                        or (rootPath .. "/" .. label)
                    local workspace_name = full_path:match(".*/(.*)")

                    -- Fallback logic
                    if not workspace_name or workspace_name == "" then
                        workspace_name = label:match("([^/]+)/?$") or label
                    end

                    wezterm.log_info(
                        "Workspace name: '" .. workspace_name .. "'"
                    )
                    win:perform_action(
                        act.SwitchToWorkspace({
                            name = workspace_name,
                            spawn = { cwd = full_path },
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
