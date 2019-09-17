set background=dark

" Remove arrow key and add the jk shortcut for escape
nnoremap <Left> <nop>
nnoremap <Right> <nop>
nnoremap <Down> <nop>
nnoremap <Up> <nop>
inoremap jk <esc>

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

" mick stuff
" Quick toggle last two jump places
"nnoremap <leader><leader> :normal! ''<CR>

" Add numbered movements to jump list
"nnoremap <expr> k (v:count > 2 ? "m'" . v:count : '') . 'k'
"nnoremap <expr> j (v:count > 2 ? "m'" . v:count : '') . 'j'

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

" go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" multi-cursor
Plug 'terryma/vim-multiple-cursors'

call plug#end()

