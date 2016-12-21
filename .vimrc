let mapleader=" "

"" bundles
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'jaawerth/nrun.vim'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'mattn/emmet-vim'
Plugin 'mxw/vim-jsx'
Plugin 'neomake/neomake'
Plugin 'pangloss/vim-javascript'
Plugin 'rking/ag.vim'
Plugin 'sjl/gundo.vim'
Plugin 'tikhomirov/vim-glsl'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'wellle/targets.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Plugin 'zweifisch/pipe2eval'

call vundle#end()

" required after bundles
filetype plugin indent on

"" ag.vim
nnoremap <leader>r :Ag!<Space>
let g:ag_prg="ag --smart-case"
let g:ag_format="%f:%l:%m"

"" commentary
au FileType python set commentstring=#\ %s

"" ctrlp
" settings
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|sass-cache)|(out)|(node_modules)$',
  \ 'file': '\v\.(pyc|orig|rej)$',
  \ }
let g:ctrlp_extensions = ['mixed']
let g:ctrlp_max_depth = 40
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
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gb :Gblame<CR>

"" gundo
nnoremap <leader>u :GundoToggle<CR>
let g:gundo_preview_bottom = 1

"" gutentags
let g:gutentags_exclude = ['build', 'node_modules']

"" neomake
autocmd! BufWritePost * Neomake
let g:neomake_error_sign = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
augroup ErrorGroup
    au!
    au ColorScheme * hi NeomakeErrorSign ctermfg=red
augroup END
let g:neomake_cpp_clang_maker = {
   \ 'args': ['-std=c++0x', '-Wc++-extensions'],
   \ }
" local eslintrc
" when switching/opening a JS buffer, set neomake's eslint path
au BufEnter *.js let b:neomake_javascript_eslint_exe = nrun#Which('eslint')

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
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Resize splits when the window is resized
augroup ResizedGroup
    autocmd! ResizedGroup
    autocmd VimResized * :wincmd =
augroup END
set splitbelow
set splitright
nnoremap <leader>q :bp\|bd #<CR>

"" mappings
" debug all the things
augroup DebuggingGroup
    autocmd! DebuggingGroup
    autocmd FileType html       nnoremap <buffer> <leader>d O<?python import pdb; pdb.set_trace() ?><Esc>:w<CR>
    autocmd FileType javascript nnoremap <buffer> <leader>d Odebugger;<Esc>:w<CR>
    autocmd FileType python     nnoremap <buffer> <leader>d Ofrom nose.tools import set_trace; set_trace()<Esc>:w<CR>
augroup END

" better saving
nnoremap <leader>w :update<CR>
" toggle line numbers
nnoremap <leader>l :set number!<CR>
" toggle insert paste mode
nnoremap <leader>p :set paste!<CR>
" quicker editing/sourcing .vimrc changes
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

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
    setlocal statusline=
    setlocal statusline+=%1*\ %<%{expand('%')}\ 
    setlocal statusline+=%2*%m\ %r%*%=
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
set nojoinspaces
" file specific
au FileType html setlocal ts=2 sts=2 sw=2 et
au FileType glsl setlocal ts=2 sts=2 sw=2 et
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
