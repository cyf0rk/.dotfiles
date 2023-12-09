local Remap = require'cyfork.keymap'
local nnoremap = Remap.nnoremap

nnoremap("<Leader>pf", function()
    require'telescope.builtin'.find_files({file_ignore_patterns={".git", "node_modules"}})
end)
nnoremap("<C-p>", function()
    require'telescope.builtin'.git_files()
end)
nnoremap("<leader>ps", function()
    require'telescope.builtin'.grep_string({ search = vim.fn.input("Grep For > ")})
end)
nnoremap("<Leader>lg", function()
	require'telescope.builtin'.live_grep({file_ignore_patterns={".git", "node_modules"}})
end)
nnoremap("<leader>vh", function()
    require'telescope.builtin'.help_tags()
end)
