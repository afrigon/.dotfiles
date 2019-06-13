set background=dark

" Use UTF-8 without BOM
set encoding=utf-8 nobomb


" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

set backspace=2

" Optimize for fast terminal connections
set ttyfast

" Make Vim drop vi compatibility
set nocompatible

" Enhance command-line completion$
set path+=**
set wildmenu

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" hybrid line numbers
set number relativenumber
set nu rnu

" set line numbers to absolute when editing another buffer
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained * set relativenumber
  autocmd BufLeave,FocusLost   * set norelativenumber
augroup END

" 4 spaces for tabs
set tabstop=4
set shiftwidth=4
set expandtab

syntax on
colorscheme slate

" Respect modeline in files
set modeline
set modelines=4

" Search
set hlsearch
set incsearch

" Status line
set laststatus=2

" Disable error bells
set noerrorbells

" Don’t show the intro message when starting Vim
set shortmess=atI

" Show the current mode
set showmode

" Show the filename in the window titlebar
set title

set autoindent

" Show the (partial) command as it’s being typed
set showcmd

" Start scrolling 8 lines before the horizontal window border
set scrolloff=8

" Automatic commands
if has("autocmd")
    " Enable file type detection
    filetype on
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    " Treat .md files as Markdown
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'terryma/vim-multiple-cursors'

call plug#end()

" rust config
let g:rustfmt_autosave = 1
let g:racer_experimental_completer = 1

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)


