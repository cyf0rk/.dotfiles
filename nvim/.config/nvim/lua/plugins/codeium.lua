return {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
        vim.keymap.set("i", "<C-g>", function()
            return vim.fn["codeium#Accept"]()
        end, { expr = true, silent = true, desc = "Codeium Accept" })
        vim.keymap.set("i", "<C-x>", function()
            return vim.fn["codeium#Clear"]()
        end, { expr = true, silent = true, desc = "Codeium Clear" })
        vim.keymap.set("i", "<C-]>", function()
            return vim.fn["codeium#CycleCompletions"](1)
        end, {
            expr = true,
            silent = true,
            desc = "Codeium Cycle Completions Next",
        })
        vim.keymap.set("n", "<leader>cd", function()
            vim.cmd.CodeiumDisable()
        end, { expr = true, silent = true, desc = "Codeium Disable" })
        vim.keymap.set("n", "<leader>ce", function()
            vim.cmd.CodeiumEnable()
        end, { expr = true, silent = true, desc = "Codeium Enable" })

        vim.g.codeium_filetypes = {
            markdown = false,
        }
    end,
}
