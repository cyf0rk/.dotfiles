local Remap = require'cyfork.keymap'
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

-- Saving
nnoremap("<C-s>", ":w<CR>")

inoremap("<C-c>", "<Esc>")
nnoremap("<C-p>", ":Telescope")

nnoremap("<leader>pv", ":Ex<CR>")

-- Tab page control
nnoremap("<A-1>", "1gt")
nnoremap("<A-2>", "2gt")
nnoremap("<A-3>", "3gt")
nnoremap("<A-4>", "4gt")
nnoremap("<A-5>", "5gt")
nnoremap("<A-6>", "6gt")
nnoremap("<A-7>", "7gt")
nnoremap("<A-8>", "8gt")
nnoremap("<A-9>", "9gt")
nnoremap("<A-0>", "0gt")

nnoremap("<A-Left>", ":-tabmove<CR>")
nnoremap("<A-Right>", ":+tabmove<CR>")

nnoremap("<C-t>", ":tabnew<CR>")

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

-- Formatting
nnoremap("<leader>f", ":Format<CR>")
nnoremap("<leader>F", ":FormatWrite<CR>")

-- Undotree
nnoremap("<leader>u", ":UndotreeShow<CR>")

-- Source config
nnoremap("<leader>?", ":source ~/.config/nvim/init.lua<CR>")

-- " Jumplist mutations
-- nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
-- nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
