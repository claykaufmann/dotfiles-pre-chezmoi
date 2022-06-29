" Author: Clay Kaufmann
" This is not used anymore, as I use nvim

" BEGIN VIMRC
"

set nocompatible

if has ('filetype')
  filetype indent plugin on
endif
" General
set history=500
filetype plugin on
filetype indent on

let mapleader = ","

nmap <leader>w :w!<cr>

" set escape to be jk 
imap jk <Esc>


"------- COLORS -------
if has('syntax')
  syntax on
endif
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif
set laststatus=2

set background=dark

" does some weird stuff that allows windows to be re-used
set hidden

" better cmdline completion
set wildmenu

" show partial commands in last line of screen
set showcmd

" highlight searches
set hlsearch

" case insenstive search, unless caps are used
set ignorecase
set smartcase

" instead of failing cmd cuz of unsaved changes, raise dialog
set confirm

" stop beeping
set visualbell

set cmdheight=2

set number
set relativenumber

"-------------------------
" INDENTATION
set shiftwidth=4
set softtabstop=4
set expandtab
set ai "auto indent
set si "smart indent

" --------- PLUGINS --------
call plug#begin()
Plug 'preservim/NERDTree'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-fugitive'
Plug 'joshdick/onedark.vim'
Plug 'airblade/vim-gitgutter'
call plug#end()

colorscheme onedark
"----------------------------
" MAPPINGS
nnoremap <C-L> :nohl<CR><C-L>

" Search bindings
map <space> /
map <C-space> ?
map <silent> <leader><cr> :noh<cr>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>
