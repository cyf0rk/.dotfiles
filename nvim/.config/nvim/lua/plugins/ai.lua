return {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("chatgpt").setup({
            api_key_cmd = os.getenv("OPENAI_API_KEY"),
            model = "gpt-4o-mini",
        })

        vim.keymap.set(
            "n",
            "<leader>cg",
            "<cmd>ChatGPT<CR>",
            { silent = true, noremap = true }
        )
    end,
}
