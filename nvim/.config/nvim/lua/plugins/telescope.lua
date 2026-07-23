return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        -- telescope's preview highlighter still calls the legacy
        -- nvim-treesitter.parsers/configs API removed by the nvim-treesitter
        -- main branch rewrite; disable it so previews fall back to regex
        -- highlighting instead of erroring on every non-file preview
        require("telescope").setup({
            defaults = {
                preview = {
                    treesitter = false,
                },
            },
        })

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
        vim.keymap.set("n", "<C-p>", builtin.git_files, {})
        vim.keymap.set("n", "<leader>ps", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set("n", "<leader>pws", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set("n", "<leader>pWs", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
        vim.keymap.set("n", "<Leader>lg", function()
            builtin.live_grep()
        end)
    end,
}
