" Vundle
if empty(glob('~/.vim/bundle/Vundle.vim'))
    silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
endif

" Make Vim drop vi compatibility
set nocompatible

filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plugin 'dracula/vim', { 'name': 'dracula' }
    Plugin 'Valloric/YouCompleteMe'
    let g:ycm_autoclose_preview_window_after_completion=1
    
    " Bracket colorizer
    Plugin 'luochen1990/rainbow'
    let g:rainbow_active = 1
    let g:rainbow_conf = { 'ctermfgs': ['Magenta', 'Yellow', 'Cyan'] }

call vundle#end()
filetype plugin indent on

" Colors
" set t_co=256 " introduce a weird mapping on 256
set background=dark
let g:dracula_italic = 0
let g:dracula_colorterm = 0
highlight Normal ctermbg=None
colorscheme dracula
syntax on

"colorscheme slate

set backspace=indent,eol,start

" Natural split direction
set splitbelow
set splitright

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

" Optimize for fast terminal connections
set ttyfast

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
set autoindent

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

" Show the (partial) command as it’s being typed
set showcmd

" Start scrolling 8 lines before the horizontal window border
set scrolloff=8

" Remove stupid underline under line numbers
hi clear CursorLineNR

" Automatic commands
if has("autocmd")
    " Enable file type detection
    filetype on
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    " Treat .md files as Markdown
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif


""" LEADER 

let mapleader = " "
nnoremap <space> <NOP>

" Select all
nnoremap <leader>a ggVG

" YouCompleteMe Definition
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


""" CONTROL

" Removes the exit help message
nnoremap <C-c> <silent> <C-c>

" Window jumps
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Prevent background
noremap <C-z> <NOP>


""" NORMAL

" Remove arrow key
nnoremap <Left> <nop>
nnoremap <Right> <nop>
nnoremap <Down> <nop>
nnoremap <Up> <nop>


""" INSERT
inoremap jk <esc>


""" VISUAL MODE

" Move block of text
vnoremap <C-j> :m '>+1<cr>gv=gv
vnoremap <C-k> :m '<-2<cr>gv=gv

" Indent in visual mode
vnoremap < <gv
vnoremap > >gv
