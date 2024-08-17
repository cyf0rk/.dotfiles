return {
	"leoluz/nvim-dap-go",
	dependencies = {
		"ray-x/go.nvim",
		"mfussenegger/nvim-dap",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require("go.format").goimport()
			end,
			group = format_sync_grp,
		})

		-- Install golang specific config
		require("dap-go").setup()
		require("go").setup()
	end,
}
