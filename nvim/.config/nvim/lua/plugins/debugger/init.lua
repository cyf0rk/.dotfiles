return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"ray-x/guihua.lua",

		-- Installs the debug adapters for you
		"williamboman/mason.nvim",
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
		"leoluz/nvim-dap-go",
		"nvim-neotest/nvim-nio",
		"mfussenegger/nvim-dap-python",
		"ray-x/go.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local daptext = require("nvim-dap-virtual-text")

		require("nvim-dap-virtual-text").setup()

		daptext.setup()
		dapui.setup({
			layouts = {
				{
					elements = {
						"console",
					},
					size = 7,
					position = "bottom",
				},
				{
					elements = {
						-- Elements can be strings or table with id and size keys.
						{ id = "scopes", size = 0.25 },
						"watches",
					},
					size = 40,
					position = "left",
				},
			},
		})

		require("mason-nvim-dap").setup({
			automatic_setup = true,
			handlers = {},
			ensure_installed = {
				"delve",
			},
		})

		-- Basic debugging keymaps, feel free to change to your liking!
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Set Breakpoint" })

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup({
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open(1)
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		vim.keymap.set("n", "<S-Right>", function()
			dapui.toggle(1)
		end)
		vim.keymap.set("n", "<S-Left>", function()
			dapui.toggle(2)
		end)

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
