local Remap = require'cyfork.keymap'
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

-- Basics
nnoremap("<leader>pv", ":Ex<CR>")
nnoremap("<C-s>", ":w<CR>")
inoremap("<C-c>", "<Esc>")

-- Moving text
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Keeping it centered
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("J", "mzJ`z")

-- Copy-paste-delete
xnoremap("<leader>pp", '"_dP')
vnoremap("<leader>y", '"+y')
nmap("<leader>Y", '"+Y')

-- Replace word under cursor
nnoremap("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Undo break points
inoremap(",", ",<c-g>u")
inoremap(".", ".<c-g>u")
inoremap("[", "[<c-g>u")
inoremap("!", "!<c-g>u")
inoremap("?", "?<c-g>u")
inoremap(":", ":<c-g>u")

-- Formatting (requires Prettier)
nnoremap("<leader>f", ":Format<CR>")
nnoremap("<leader>F", ":FormatWrite<CR>")

-- Undotree
nnoremap("<leader>u", ":UndotreeShow<CR>")

-- Source config
nnoremap("<leader>?", ":source ~/.config/nvim/init.lua<CR>")

-- Move errors
nnoremap("<C-k>", "<cmd>cnext<CR>zz")
nnoremap("<C-j>", "<cmd>cprev<CR>zz")
nnoremap("<leader>k", "<cmd>lnext<CR>zz")
nnoremap("<leader>j", "<cmd>lprev<CR>zz")
nnoremap("<leader>j", "<cmd>lprev<CR>zz")
