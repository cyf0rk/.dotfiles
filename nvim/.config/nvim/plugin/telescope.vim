nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>pf :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fg :lua require('telescope.builtin').live_grep()<CR>

nnoremap <leader>vrc :lua require('lua_plugins.telescope').search_dotfiles()<CR>
