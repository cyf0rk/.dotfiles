return {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        local ls = require("luasnip")
        require("luasnip").setup({ enable_autosnippets = true })
        require("luasnip.loaders.from_lua").load({
            paths = "~/.config/nvim/lua/snippets/",
        })

        -- This will expand the current item or jump to the next item within the snippet.
        vim.keymap.set({ "i", "s" }, "<C-k>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end, { silent = true })

        -- This always moves to the previous item within the snippet
        vim.keymap.set({ "i", "s" }, "<C-j>", function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, { silent = true })

        -- This is useful for choice nodes
        vim.keymap.set("i", "<C-l>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end)
    end,
}
