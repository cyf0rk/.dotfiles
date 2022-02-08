set path+=**

" Nice menu when typing ':find *.js'
set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*

call plug#begin(stdpath('config') . '/plugged')
" Telescope specific
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" My pencils
Plug 'gruvbox-community/gruvbox'

" Vimitor history
Plug 'mbbill/undotree'

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'onsails/lspkind-nvim'

Plug 'glepnir/lspsaga.nvim'
Plug 'simrat39/symbols-outline.nvim'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

" Shopify
Plug 'tpope/vim-liquid'

" Neovim Tree-sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Prettier
Plug 'sbdchd/neoformat'

" Auto closing ( [ {
Plug 'jiangmiao/auto-pairs'

" Comments
Plug 'tpope/vim-commentary'

call plug#end()

lua require('lua_plugins')

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}
let g:neoformat_run_all_formatters = 1

let mapleader = " "

nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize30<CR>

" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <C-c> <esc>
" Copy-paste-delete
nnoremap Y y$
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap [ [<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap : :<c-g>u

" Jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

" Saving
nnoremap <C-s> :w<CR>

" Window resize
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>

" Formatting
nnoremap <leader>nf :Neoformat<CR>

" Undotree
nnoremap <leader>u :UndotreeShow<CR>

if has("persistent_undo")
    let target_path = expand('~/.dotfiles/nvim/.config/nvim/undodir')

    " create the directory and any parent directories
    " if the location does not exist
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup THE_CYBORG
    autocmd!
    autocmd BufWritePre lua,cpp,c,h,hpp,cxx,cc Neoformat
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END
