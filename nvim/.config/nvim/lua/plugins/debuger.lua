return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- Creates a beautiful debugger UI
        {
            "rcarriga/nvim-dap-ui",
            dependencies = "nvim-neotest/nvim-nio",
            config = function()
                local dap, dapui = require("dap"), require("dapui")

                dapui.setup()

                dap.listeners.before.attach.dapui_config = function()
                    dapui.open()
                end
                dap.listeners.before.launch.dapui_config = function()
                    dapui.open()
                end
                dap.listeners.before.event_terminated.dapui_config = function()
                    dapui.close()
                end
                dap.listeners.before.event_exited.dapui_config = function()
                    dapui.close()
                end

                -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
                vim.keymap.set(
                    "n",
                    "<F7>",
                    dapui.toggle,
                    { desc = "Debug: See last session result." }
                )

                vim.keymap.set("n", "<S-Right>", function()
                    dapui.toggle(1)
                end)
                vim.keymap.set("n", "<S-Left>", function()
                    dapui.toggle(2)
                end)
            end,
        },

        -- Installs the debug adapters for you
        {
            "jay-babu/mason-nvim-dap.nvim",
            dependencies = "mason.nvim",
            cmd = { "DapInstall", "DapUninstall" },
            opts = {
                automatic_installation = true,
                handlers = {},
                ensure_installed = {
                    "delve",
                },
            },
        },

        -- Add your own debuggers here
        {
            "leoluz/nvim-dap-go",
            config = function()
                require("dap-go").setup()
            end,
        },
        {
            "mfussenegger/nvim-dap-python",
            config = function()
                require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
            end,
        },
    },
    config = function()
        local dap = require("dap")

        -- Basic debugging keymaps, feel free to change to your liking!
        vim.keymap.set(
            "n",
            "<F5>",
            dap.continue,
            { desc = "Debug: Start/Continue" }
        )
        vim.keymap.set(
            "n",
            "<F1>",
            dap.step_into,
            { desc = "Debug: Step Into" }
        )
        vim.keymap.set(
            "n",
            "<F2>",
            dap.step_over,
            { desc = "Debug: Step Over" }
        )
        vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
        vim.keymap.set(
            "n",
            "<leader>b",
            dap.toggle_breakpoint,
            { desc = "Debug: Toggle Breakpoint" }
        )
        vim.keymap.set("n", "<leader>B", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "Debug: Set Breakpoint" })

        vim.keymap.set("n", "<leader>cs", function()
            dap.close()
        end)

        vim.keymap.set("n", "<Up>", function()
            dap.continue()
        end)
        vim.keymap.set("n", "<Down>", function()
            dap.step_over()
        end)
        vim.keymap.set("n", "<Right>", function()
            dap.step_into()
        end)
        vim.keymap.set("n", "<Left>", function()
            dap.step_out()
        end)
        vim.keymap.set("n", "<Leader>b", function()
            dap.toggle_breakpoint()
        end)
        vim.keymap.set("n", "<Leader>B", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end)
        vim.keymap.set("n", "<leader>rc", function()
            dap.run_to_cursor()
        end)
        vim.keymap.set("n", "<Leader>cb", function()
            dap.clear_breakpoints()
        end)
    end,
}
