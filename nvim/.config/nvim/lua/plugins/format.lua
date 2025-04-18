return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                svelte = { "prettierd", "prettier" },
                javascript = { "prettierd", "prettier" },
                typescript = { "prettierd", "prettier" },
                javascriptreact = { "prettierd", "prettier" },
                typescriptreact = { "prettierd", "prettier" },
                json = { "prettierd", "prettier" },
                graphql = { "prettierd", "prettier" },
                markdown = { "prettierd", "prettier" },
                liquid = { "prettier" },
                html = { "prettier" },
                bash = { "beautysh" },
                rust = { "rustfmt" },
                css = { "prettierd", "prettier" },
                scss = { "prettierd", "prettier" },
                sh = { "shellcheck" },
                go = { "gofmt" },
                python = { "isort", "black" },
            },
        })

        -- Go formatting
        local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
                require("go.format").goimport()
            end,
            group = format_sync_grp,
        })

        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
