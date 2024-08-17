return {
	-- linting
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>ll", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
		vim.keymap.set("n", "<leader>af", "mF<cmd>!eslint_d --stdin --fix-to-stdout --stdin-filename %<CR>`F", {
			silent = true,
			desc = "Autofix entire buffer with eslint_d",
		})
		vim.keymap.set("v", "<leader>af", "<cmd>!eslint_d --stdin --fix-to-stdout --stdin-filename %<CR>gv", {
			silent = true,
			desc = "Autofix visual selection with eslint_d",
		})
	end,
}
