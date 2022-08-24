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
 Plug 'dracula/vim'
 Plug 'vim-airline/vim-airline'
 Plug 'airblade/vim-gitgutter'
 Plug 'ryanoasis/vim-devicons'
 Plug 'preservim/nerdtree'
 Plug 'JuliaEditorSupport/julia-vim'
 Plug 'preservim/nerdcommenter'
 Plug 'prabirshrestha/vim-lsp'
 Plug 'mattn/vim-lsp-settings'
call plug#end()


let g:airline_powerline_fonts = 1
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

map <C-n> :NERDTreeToggle<CR>

