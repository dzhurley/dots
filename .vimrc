let mapleader=" "

"" bundles
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'fcpg/vim-altscreen'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'neomake/neomake'
Plugin 'jaawerth/nrun.vim'
Plugin 'rking/ag.vim'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'wellle/targets.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'

Plugin 'cakebaker/scss-syntax.vim'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'mattn/emmet-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'neoclide/vim-jsx-improve'
Plugin 'tikhomirov/vim-glsl'

call vundle#end()

" required after bundles
filetype plugin indent on

"" ag.vim
nnoremap <leader>r :Ag!<Space>
let g:ag_prg="ag --smart-case"
let g:ag_format="%f:%l:%m"

"" ctrlp
" settings
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.git|node_modules$',
  \ 'file': '\v\.(pyc|orig|rej)$',
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

"" gutentags
let g:gutentags_ctags_exclude = ['build']
let g:gutentags_ctags_exclude = ['~/.cache']

"" neomake
autocmd! BufWritePost * Neomake
let g:neomake_error_sign = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
augroup ErrorGroup
    au!
    au ColorScheme * hi NeomakeErrorSign ctermfg=red
augroup END
let b:neomake_javascript_eslint_exe = nrun#Which('eslint')
let g:neomake_python_enabled_makers = ['pylint']
let b:neomake_python_pylint_maker = {
  \ 'args': [
      \ '--rcfile', 'config/pylintrc',
      \ '--output-format=text',
      \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg} [{msg_id}]"',
      \ '--reports=no'
  \ ]}

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
autocmd VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
"" alternate between block and vertical line cursor on normal/insert modes
autocmd InsertEnter,InsertChange *
\ if v:insertmode == 'i' |
\   silent execute '!echo -ne "\e[6 q"' | redraw! |
\ elseif v:insertmode == 'r' |
\   silent execute '!echo -ne "\e[4 q"' | redraw! |
\ endif
autocmd VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!

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
    autocmd FileType javascript nnoremap <buffer> <leader>d Odebugger;<Esc>:w<CR>
    autocmd FileType python     nnoremap <buffer> <leader>d Oimport pdb; pdb.set_trace()<Esc>:w<CR>
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
set matchpairs+=<:>
set modelines=0
set shortmess+=I
set showbreak=↪
set synmaxcol=200
