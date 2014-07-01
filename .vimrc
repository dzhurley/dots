set nocompatible

"" vundle stuffs
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"" bundles
Plugin 'gmarik/vundle'

Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'nono/vim-handlebars'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-scripts/bufkill.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'

call vundle#end()

" required after bundles
filetype plugin indent on

"" syntastic
let g:syntastic_check_on_open=1
let g:syntastic_python_checkers = ['flake8', 'pep8', 'pyflakes', 'python']

"" ctrlp
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_open_multiple_files = '1v'
let g:ctrlp_extensions = ['mixed']
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|sass-cache)|(built-js|out)$',
  \ 'file': '\v\.(pyc|orig|rej)$',
  \ }

"" commentary
autocmd FileType handlebars set commentstring={{!\ %s\ }}

"" zencoding
let g:user_emmet_leader_key = '<c-e>'
let g:user_emmet_settings = {
\  'handlebars' : {
\    'filters' : 'html',
\    'indentation' : '  '
\  },
\  'html' : {
\    'filters' : 'html',
\    'indentation' : '  '
\  }
\}

"" bufkill.vim
cnoremap bw BW
cnoremap bd BD

"" mappings
" leader shorthand
let mapleader=" "
" debug all the things
nmap <leader>p Oimport pdb; pdb.set_trace()<Esc>:w<CR>
nmap <leader>g O<?python import pdb; pdb.set_trace() ?><Esc>:w<CR>
nmap <leader>n Ofrom nose.tools import set_trace; set_trace()<Esc>:w<CR>
nmap <leader>d Odebugger;<Esc>:w<CR>
" better saving
nmap <leader>w :update<CR>

"" whitespace
" defaults
set cindent
set ts=4 sts=4 sw=4 et
set backspace=indent,eol,start
" file specific
autocmd FileType html setlocal ts=2 sts=2 sw=2 et
autocmd FileType handlebars setlocal ts=2 sts=2 sw=2 et
let g:pymode_indent = 0

"" searching
set gdefault
set ignorecase
set smartcase
set infercase
set incsearch

"" file/buffer
set wildmenu
set wildmode=longest:full,full
set hidden
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"" vim management
set nobackup
set noswapfile

"" status line
set ruler
set laststatus=2

"" misc
set history=1000
set modelines=0
set encoding=utf-8
set matchpairs+=<:>
set complete=.,w,b,u,t
set lazyredraw

"" colors
syntax on
set background=dark
colorscheme solarized

" cursor highlighting
set cursorline
hi cursorline cterm=bold ctermbg=4
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END
