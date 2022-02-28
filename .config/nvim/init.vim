let mapleader=" "

call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'overcache/NeoSolarized'
Plug 'rking/ag.vim'
Plug 'sheerun/vim-polyglot'
Plug 'leafOfTree/vim-svelte-plugin'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'

call plug#end()

"" ag.vim
nnoremap <leader>r :Ag!<Space>
let g:ag_prg="ag --smart-case"
let g:ag_format="%f:%l:%m"

" coc-nvim
let g:coc_global_extensions = [
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-svelte',
  \ 'coc-tsserver',
  \ 'coc-pyright'
  \ ]
nmap <leader>p <Plug>(coc-format)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> K :call CocActionAsync('doHover')<CR>

nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"" ctrlp
" settings
nnoremap <leader>f :CtrlPMixed<CR>
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\..*|node_modules|dist|build$',
  \ 'file': '\v\.(orig|rej)|__.*$',
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

" emmet
let g:user_emmet_settings = {
\  'html' : { 'filters': 'html', 'indentation': '  ' },
\  'javascript' : { 'extends' : 'jsx' }
\}

"" gundo
nnoremap <leader>u :MundoToggle<CR>
let g:mundo_preview_bottom = 1

" debugger
augroup DebuggingGroup
    autocmd! DebuggingGroup
    autocmd FileType typescriptreact nnoremap <buffer> <leader>d Odebugger;<Esc>:w<CR>
    autocmd FileType typescript nnoremap <buffer> <leader>d Odebugger;<Esc>:w<CR>
    autocmd FileType javascript nnoremap <buffer> <leader>d Odebugger;<Esc>:w<CR>
augroup END

"" emmet
let g:user_emmet_leader_key = '<c-t>'

" config
nnoremap <leader>e :vsp ~/.config/nvim/init.vim<CR>
nnoremap <leader>s :source ~/.config/nvim/init.vim<CR>

" buffer
set hidden
set wildignorecase
set wildmode=longest:full,full
set splitbelow
set splitright

" completion
set complete=.,w,b
set completeopt=longest,menu

" resize splits when the window is resized
augroup ResizedGroup
    autocmd! ResizedGroup
    autocmd VimResized * :wincmd =
augroup END
" move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" navigate through visually wrapped lines
noremap j gj
noremap k gk

" make Y consistent with D and C
nnoremap Y y$

"" colors
set termguicolors
colorscheme NeoSolarized
" statusline and associated
hi! link User1 DiffText
hi! link User2 DiffDelete
hi! link User3 DiffAdd
hi! link VertSplit LineNr
hi! link StatusLine LineNr
hi! link StatusLineNC SpecialKey

"" cursorline
set cursorline
hi! link SignColumn Normal
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

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

" better saving
nnoremap <leader>w :update<CR>

" make `foo-bar` work with w, *, etc in css files
au! FileType css setl iskeyword+=-

" searching
set gdefault
set ignorecase
set nohlsearch
set smartcase

" spacing
set nojoinspaces
set smartindent
set ts=2 sts=2 sw=2 et

" misc
set lazyredraw
set modelines=0
set nofoldenable
set noshowcmd
set noswapfile
set shortmess+=I
set synmaxcol=200
