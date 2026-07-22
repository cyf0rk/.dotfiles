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
        table.insert(args, "--max-depth=4")
    else
        table.insert(args, ".")
        table.insert(args, "--max-depth=1")
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

    local function switch_to_workspace(win, pn, full_path, workspace_name)
        wezterm.log_info("Workspace name: '" .. workspace_name .. "'")
        win:perform_action(
            act.SwitchToWorkspace({
                name = workspace_name,
                spawn = { cwd = full_path },
            }),
            pn
        )
    end

    window:perform_action(
        act.InputSelector({
            action = wezterm.action_callback(function(win, pn, id, label)
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

                    -- If a workspace with this name already exists, ask for
                    -- a different name instead of switching into it, so
                    -- re-opening the same folder always spawns a new
                    -- workspace.
                    local existing = {}
                    for _, name in ipairs(wezterm.mux.get_workspace_names()) do
                        existing[name] = true
                    end

                    if existing[workspace_name] then
                        win:perform_action(
                            act.PromptInputLine({
                                description = "Workspace '"
                                    .. workspace_name
                                    .. "' already exists. Enter a new name:",
                                action = wezterm.action_callback(
                                    function(win2, pn2, line)
                                        if not line or line == "" then
                                            wezterm.log_info("Cancelled")
                                            return
                                        end
                                        switch_to_workspace(
                                            win2,
                                            pn2,
                                            full_path,
                                            line
                                        )
                                    end
                                ),
                            }),
                            pn
                        )
                    else
                        switch_to_workspace(win, pn, full_path, workspace_name)
                    end
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
