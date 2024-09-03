return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("neogit").setup({
            integrations = {
                diffview = true,
            },
        })
        local cyfork_Neogit = vim.api.nvim_create_augroup("cyfork_Neogit", {})

        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            group = cyfork_Neogit,
            pattern = "*",
            callback = function()
                local opts = {
                    silent = true,
                    noremap = true,
                }
                vim.keymap.set("n", "<leader>gs", function()
                    vim.cmd.Neogit()
                end, opts)
                vim.keymap.set("n", "<leader>gb", function()
                    vim.cmd.Telescope({ "git_branches" })
                end, opts)
                vim.keymap.set("n", "<leader>gc", function()
                    vim.cmd.Neogit({ "commit" })
                end, opts)
                vim.keymap.set("n", "<leader>gp", function()
                    vim.cmd.Neogit({ "pull" })
                end, opts)
                vim.keymap.set("n", "<leader>gP", function()
                    vim.cmd.Neogit({ "push" })
                end, opts)
            end,
        })
    end,
}
