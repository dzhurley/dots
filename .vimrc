let mapleader=" "

"" bundles
call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'dense-analysis/ale'
Plug 'fcpg/vim-altscreen'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mattn/emmet-vim'
Plug 'rking/ag.vim'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'

Plug 'sheerun/vim-polyglot'
Plug 'evanleck/vim-svelte'
Plug 'altercation/vim-colors-solarized'

call plug#end()

"" ag.vim
nnoremap <leader>r :Ag!<Space>
let g:ag_prg="ag --smart-case"
let g:ag_format="%f:%l:%m"

"" ale
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_linter_aliases = {
\   'typescriptreact': ['typescript', 'tsx'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\   'typescript': ['prettier', 'eslint'],
\   'python': ['black'],
\}
nnoremap <leader>p :ALEFix<CR>

"" ctrlp
" settings
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\..*|node_modules|dist|build$',
  \ 'file': '\v\.(pyc|orig|rej)|tags|__.*$',
  \ }
let g:ctrlp_max_files = 0
let g:ctrlp_extensions = ['mixed']
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
\  'html' : { 'filters': 'html', 'indentation': '  ' },
\  'javascript' : { 'extends' : 'jsx' }
\}

"" gundo
nnoremap <leader>u :GundoToggle<CR>
let g:gundo_preview_bottom = 1
let g:gundo_prefer_python3 = 1

"" gutentags
let g:gutentags_cache_dir = '~/.vim/tags'
let g:gutentags_ctags_exclude = ['node_modules', 'dist', 'build', '\.*', '__.*', '*.bundle.js']

"" colors
syntax on
set background=dark
colorscheme solarized
hi Normal ctermbg=NONE
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
"" alternate between block and vertical line cursor on normal/insert modes
augroup AlternateCursor
    au!
    au InsertLeave * silent execute '!echo -ne "\e[2 q"'
    au InsertEnter * silent execute '!echo -ne "\e[6 q"'
augroup END

"" file/buffer
set hidden
set wildmenu
set wildignorecase
set wildmode=longest:full,full
" move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Resize splits when the window is resized
augroup ResizedGroup
    autocmd! ResizedGroup
    autocmd VimResized * :wincmd =
augroup END
set equalalways
set splitbelow
set splitright
nnoremap <leader>q :bp\|bd #<CR>

"" mappings
" debug all the things
augroup DebuggingGroup
    autocmd! DebuggingGroup
    autocmd FileType typescript nnoremap <buffer> <leader>d Odebugger;<Esc>:w<CR>
    autocmd FileType javascript nnoremap <buffer> <leader>d Odebugger;<Esc>:w<CR>
    autocmd FileType python     nnoremap <buffer> <leader>d Oimport pdb; pdb.set_trace()<Esc>:w<CR>
augroup END

" better saving
nnoremap <leader>w :update<CR>

" navigate through visually wrapped lines
noremap j gj
noremap k gk
" make Y consistent with D and C
nnoremap Y y$
" no more Ex
noremap Q <Nop>

"" searching
set gdefault
set ignorecase
set smartcase
set infercase
set incsearch

"" status line
" toggle active/inactive
augroup Statusline
    autocmd! Statusline
    autocmd VimEnter,WinEnter,BufWinEnter * call <SID>SetFullStatusline()
    autocmd WinLeave * call <SID>SetSimpleStatusline()
augroup END
" active line
function! s:SetFullStatusline()
    setlocal statusline=%1*\ %<%{expand('%')}\ 
    setlocal statusline+=%2*%m\ %r%*%=
    setlocal statusline+=%3*\ %l/%L\ 
endfunction
" inactive line
function! s:SetSimpleStatusline()
    setlocal statusline=\ %<%{pathshorten(expand('%'))}\ 
    setlocal statusline+=%m\ %r%=%l/%L\ 
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
set nojoinspaces
" file specific
au FileType javascript setlocal ts=2 sts=2 sw=2 et
au FileType typescript setlocal ts=2 sts=2 sw=2 et
au FileType html setlocal ts=2 sts=2 sw=2 et
au FileType glsl setlocal ts=2 sts=2 sw=2 et
au FileType yml setlocal ts=2 sts=2 sw=2 et
au FileType yaml setlocal ts=2 sts=2 sw=2 et
let g:pymode_indent = 0

"" misc
runtime macros/matchit.vim
" show line contents instead of '@@@..' if too long
set display+=lastline
set encoding=utf-8
set nofoldenable
" make `foo-bar` work with w, *, etc in css/scss files
au! FileType css,scss setl iskeyword+=-
set lazyredraw
set matchpairs+=<:>
set modelines=0
set mouse=""
set shortmess+=I
set showbreak=↪
set synmaxcol=200
set ttyfast
