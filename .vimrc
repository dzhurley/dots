let mapleader=" "

"" bundles
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle'

Plugin 'altercation/vim-colors-solarized'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'gabesoft/vim-ags'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-scripts/bufkill.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'

call vundle#end()

" required after bundles
filetype plugin indent on

"" ag.vim
nmap <leader>r :Ags<Space>

"" bufkill.vim
cab Bw BW
cab Bd BD
cab bW BW
cab bD BD
cab bw BW
cab bd BD

"" commentary
au FileType python set commentstring=#\ %s

"" ctrlp
" settings
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|sass-cache)|(out)$',
  \ 'file': '\v\.(pyc|orig|rej)$',
  \ }
let g:ctrlp_extensions = ['mixed']
let g:ctrlp_open_multiple_files = '1v'
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
let g:ctrlp_status_func = {
            \ 'main': 'CtrlPMain',
            \ 'prog': 'CtrlPProg'
            \ }
" theme
function! CtrlPMain(...)
    return '%1* ' . a:5 . '%=' . fnamemodify(getcwd(), ':~') . ' '
endfunction
function! CtrlPProg(...)
    return '%1* ' . fnamemodify(getcwd(), ':~') . ' (' . a:1 . ')'
endfunction

"" emmet
let g:user_emmet_leader_key = '<c-t>'
let g:user_emmet_settings = {
\  'html' : { 'filters': 'html', 'indentation': '  ' }
\}

"" fugitive
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>gb :Gblame<CR>

"" gundo
nnoremap <leader>u :GundoToggle<CR>
let g:gundo_preview_bottom = 1

"" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_python_checkers = ['flake8', 'pep8', 'pyflakes', 'python']
let g:syntastic_stl_format = '%E{E:%fe}%B{, }%W{W:%fw}'

"" abbreviations for tyops
cab W! w!
cab Q! q!
cab Wa wa
cab wA wa
cab WA wa
cab Qa qa
cab qA qa
cab QA qa
cab Wq wq
cab wQ wq
cab WQ wq
cab W w
cab Q q

"" colors
syntax on
set background=dark
colorscheme solarized
" statusline and associated
hi User1 ctermfg=4 ctermbg=0
hi User2 ctermfg=1 ctermbg=0
hi User3 ctermfg=2 ctermbg=0
hi! link VertSplit LineNr
hi! link StatusLine LineNr
hi! link StatusLineNC SpecialKey

"" completion
set complete=.,w,b
set completeopt=longest,menu

"" cursorline
set cursorline
hi! link SignColumn Normal
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END
" line cursor in insert, block cursor otherwise
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"" file/buffer
set hidden
set wildmenu
set wildignorecase
set wildmode=longest:full,full
" move between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Resize splits when the window is resized
au VimResized * :wincmd =

"" mappings
" debug all the things
nmap <leader>p Oimport pdb; pdb.set_trace()<Esc>:w<CR>
nmap <leader>t O<?python import pdb; pdb.set_trace() ?><Esc>:w<CR>
nmap <leader>n Ofrom nose.tools import set_trace; set_trace()<Esc>:w<CR>
nmap <leader>d Odebugger;<Esc>:w<CR>
" better saving
nmap <leader>w :update<CR>
" navigate through visually wrapped lines
noremap j gj
noremap k gk
" make Y consistent with D and C
nnoremap Y y$
" toggle line numbers
nmap <leader>l :set number!<CR>
" no more Ex
map Q <Nop>

"" searching
set gdefault
set ignorecase
set smartcase
set infercase
set incsearch

"" status line
" toggle active/inactive
augroup Statusline
    au! Statusline
    au VimEnter,WinEnter,BufWinEnter * call <SID>SetFullStatusline()
    au WinLeave * call <SID>SetSimpleStatusline()
augroup END
" active line
function! s:SetFullStatusline()
    setlocal statusline=
    setlocal statusline+=%1*\ %<%{expand('%')}\ 
    setlocal statusline+=%2*%m\ %r%*%=
    setlocal statusline+=%2*%{SyntasticStatuslineFlag()}
    setlocal statusline+=%3*\ %{fugitive#head()}\ 
endfunction
" inactive line
function! s:SetSimpleStatusline()
    setlocal statusline=
    setlocal statusline+=\ %<%{pathshorten(expand('%'))}\ 
    setlocal statusline+=%m\ %r%=
    setlocal statusline+=%{fugitive#head()}\ 
endfunction
set laststatus=2

"" vim management
set autoread
set nobackup
set noswapfile

"" whitespace
set cindent
set ts=4 sts=4 sw=4 et
set backspace=indent,eol,start
set expandtab
set smarttab
" file specific
au FileType html setlocal ts=2 sts=2 sw=2 et
let g:pymode_indent = 0

"" misc
runtime macros/matchit.vim
" show line contents instead of '@@@..' if too long
set display+=lastline
set encoding=utf-8
set nofoldenable
" make `foo-bar` work with w, *, etc in css/scss files
au! FileType css,scss setl iskeyword+=-
set matchpairs+=<:>
set modelines=0
set shortmess+=I
set showbreak=↪
