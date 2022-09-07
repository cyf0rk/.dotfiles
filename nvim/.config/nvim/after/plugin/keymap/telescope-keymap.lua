local Remap = require'cyfork.keymap'
local nnoremap = Remap.nnoremap

nnoremap("<C-p>", ":Telescope")
nnoremap("<leader>ps", function()
    require'telescope.builtin'.grep_string({ search = vim.fn.input("Grep For > ")})
end)
nnoremap("<C-p>", function()
    require'telescope.builtin'.git_files()
end)
nnoremap("<Leader>pf", function()
    require'telescope.builtin'.find_files({file_ignore_patterns={".git", "node_modules"}})
end)
nnoremap("<Leader>lg", function()
	require'telescope.builtin'.live_grep({file_ignore_patterns={".git", "node_modules"}})
end)

nnoremap("<leader>pw", function()
    require'telescope.builtin'.grep_string { search = vim.fn.expand("<cword>") }
end)
nnoremap("<leader>pb", function()
    require'telescope.builtin'.buffers()
end)
nnoremap("<leader>vh", function()
    require'telescope.builtin'.help_tags()
end)
-- nnoremap <leader>vrc :lua require'lua_plugins.telescope'.search_dotfiles()<CR>
