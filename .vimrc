set nocompatible
let mapleader=" "

"" bundles
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle'

Plugin 'altercation/vim-colors-solarized'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/vim-pseudocl'
Plugin 'junegunn/vim-oblique'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-scripts/bufkill.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'

call vundle#end()

" required after bundles
filetype plugin indent on

"" ag.vim
nmap <leader>r :Ag! 
let g:agprg="ag --smart-case"
let g:agformat="%f:%l:%m"

"" bufkill.vim
cab bw BW
cab bd BD

"" commentary
autocmd FileType python set commentstring=#\ %s

"" ctrlp
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|sass-cache)|(built-js|out)$',
  \ 'file': '\v\.(pyc|orig|rej)$',
  \ }
let g:ctrlp_extensions = ['mixed']
let g:ctrlp_open_multiple_files = '1v'
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'

"" emmet
let g:user_emmet_leader_key = '<c-t>'
let g:user_emmet_settings = {
\  'html' : { 'filters': 'html', 'indentation': '  ' }
\}

"" lightline
let g:lightline = {
            \ 'colorscheme': 'solarized_dark',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'fugitive', 'readonly' ],
            \             [ 'filename', 'modified' ] ],
            \   'right': [ [ 'lineinfo' ], [ 'percent' ] ]
            \ },
            \ 'component': {
            \   'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
            \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
            \ },
            \ }

"" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open=1
let g:syntastic_enable_highlighting = 1
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_python_checkers = ['flake8', 'pep8', 'pyflakes', 'python']

"" abbreviations for tyops
cab W! w!
cab Q! q!
cab Wq wq
cab Wa wa
cab wA wa
cab Qa qa
cab qA qa
cab wQ wq
cab WQ wq
cab W w
cab Q q

"" colors
syntax on
set background=dark
colorscheme solarized

"" completion
set complete=.,w,b,u
set completeopt=longest,menu

"" cursorline
set cursorline
hi! link SignColumn Normal
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

"" file/buffer
set hidden
set wildmenu
set wildmode=longest:full,full
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Resize splits when the window is resized
au VimResized * :wincmd =

"" mappings
" debug all the things
nmap <leader>p Oimport pdb; pdb.set_trace()<Esc>:w<CR>
nmap <leader>n Ofrom nose.tools import set_trace; set_trace()<Esc>:w<CR>
nmap <leader>d Odebugger;<Esc>:w<CR>
" better saving
nmap <leader>w :update<CR>
" navigate through visually wrapped lines
noremap j gj
noremap k gk
noremap gj j
noremap gk k

"" searching
set gdefault
set ignorecase
set smartcase
set infercase
set incsearch

"" status line
set ruler
set laststatus=2

"" vim management
set autoread
set nobackup
set noswapfile

"" whitespace
set cindent
set ts=4 sts=4 sw=4 et
set backspace=indent,eol,start
set smarttab
" file specific
autocmd FileType html setlocal ts=2 sts=2 sw=2 et
let g:pymode_indent = 0

"" misc
" show line contents instead of '@@@..' if too long
set display+=lastline
set encoding=utf-8
" make `foo-bar` work with w, *, etc
set iskeyword+=-
set matchpairs+=<:>
set modelines=0
set noshowmode
set number
set showbreak=↪
