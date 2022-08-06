local Remap = require('cyfork.keymap')
local inoremap = Remap.inoremap
local nnoremap = Remap.nnoremap
local ls = require "luasnip"

-- This will expand the current item or jump to the next item within the snippet.
vim.keymap.set({"i", "s"}, "<C-k>", function()
    if ls.expand_or_jumpable() then
        print("c-k")
        ls.expand_or_jump()
    end
end, { silent = true })

-- This always moves to the previous item within the snippet
vim.keymap.set({"i", "s"}, "<C-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, {silent = true})

-- -- This will expand the current item or jump to the next item within the snippet.
-- inoremap("<C-k>", function()
--     if ls.expand_or_jumpable() then
--         ls.expand_or_jump()
--     end
-- end, {silent = true})

-- -- This always moves to the previous item within the snippet
-- inoremap("<C-j>", function()
--     if ls.jumpable(-1) then
--         ls.jump(-1)
--     end
-- end, {silent = true})

-- This is useful for choice nodes
inoremap("<C-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

-- Shortcut to source my luasnips file again, which will reload my snippets
nnoremap("<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip-conf.lua<CR>")
