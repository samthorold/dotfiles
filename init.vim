" Sam Thorold
" sam.thorold@gmail.com
" 2022-08-04

syntax on

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set ruler
set number
set relativenumber

set backupcopy=yes

set ignorecase
set smartcase

set autoindent

set mouse=a

set hlsearch

filetype on
filetype plugin on

autocmd FileType make setlocal noexpandtab
autocmd Filetype r setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype markdown setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2

call plug#begin("~/.vim/plugged")
 Plug 'preservim/nerdtree'
 Plug 'prabirshrestha/vim-lsp'
 Plug 'mattn/vim-lsp-settings'
call plug#end()


if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

map <C-n> :NERDTreeToggle<CR>

