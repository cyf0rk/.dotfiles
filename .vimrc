set gfn=Fira\ Code:h11
set exrc
set guicursor=
set relativenumber
set nu
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set colorcolumn=80
set signcolumn=yes

call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
call plug#end()

colorscheme gruvbox

let mapleader = " "

augroup CYBORG07
    autocmd!
augroup END
