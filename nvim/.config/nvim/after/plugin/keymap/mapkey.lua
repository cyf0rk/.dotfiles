local Remap = require("cyfork.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

-- Saving
nnoremap("<C-s>", ":w<CR>")

inoremap("<C-c>", "<Esc>")
nnoremap("<C-p>", ":Telescope")
nnoremap("<leader>ps", function()
    require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})
end)

nnoremap("<leader>pv", "0 :wincmd v<bar> :Ex <bar> :vertical resize30<CR>")

-- Moving text
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- Keeping it centered
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("J", "mzJ`z")

-- Copy-paste-delete
nnoremap("Y", "yg$")

xnoremap("<leader>p", "\"_dP")

nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
nmap("<leader>Y", "\"+Y")

nnoremap("<leader>d", "\"_d")
vnoremap("<leader>d", "\"_d")

vnoremap("<leader>d", "\"_d")

nnoremap("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Undo break points
inoremap(",", ",<c-g>u")
inoremap(".", ".<c-g>u")
inoremap("[", "[<c-g>u")
inoremap("!", "!<c-g>u")
inoremap("?", "?<c-g>u")
inoremap(":", ":<c-g>u")

-- Window resize
nnoremap("<leader>+", ":vertical resize +5<CR>")
nnoremap("<leader>-", ":vertical resize -5<CR>")

-- " Formatting
nnoremap("<leader>nf", ":Neoformat<CR>")

-- " Undotree
nnoremap("<leader>u", ":UndotreeShow<CR>")

-- " Jumplist mutations
-- nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
-- nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
