" mapleader
let mapleader = "\<Space>"
let g:mapleader = mapleader
noremap <leader><space> <space>

" plugins
call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" completion
if has('lua')
  if (version >= 704 || version == 703 && has('patch885'))
    Plug 'Shougo/neocomplete.vim'
    let s:completion_prefix = 'neocomplete#'
  else
    Plug 'Shougo/neocomplcache.vim'
    let s:completion_prefix = 'neocomplcache_'
  endif
else
  Plug 'ervandew/supertab'
endif
if exists('s:completion_prefix')
  let g:{s:completion_prefix}enable_at_startup = 1
  let g:{s:completion_prefix}enable_smart_case = 1
  let g:{s:completion_prefix}enable_auto_delimiter = 1
endif

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
nnoremap <C-e> :NERDTreeToggle<CR>

Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'yuichiro-s/fzf.vim'
let g:fzf_buffers_jump = 1
nnoremap <silent> <leader>x  <esc>:History<cr>
nnoremap <silent> <leader>z  <esc>:Files<cr>
nnoremap <silent> <leader>c  <esc>:Buffers<cr>
nnoremap          <leader>a  <esc>:Ag<space>
nnoremap <silent> <leader>A  <esc>:exe('Ag '.expand('<cword>'))<cr>
nnoremap <silent> <leader>l  <esc>:Lines<cr>
nnoremap <silent> <leader>:  <esc>:History:<cr>
nnoremap <silent> <leader>;  <esc>:Commands<cr>
nnoremap <silent> <leader>]  <esc>:exe('Tags ^'.expand('<cword>').' ')<cr>
nnoremap <silent> <leader>?  <esc>:Helptags<cr>
nnoremap <silent> <leader>gz <esc>:GFiles<cr>
nnoremap <silent> <leader>gs <esc>:GFiles?<cr>
nnoremap          <leader>gg <esc>:GGrep<space>
nnoremap <silent> <leader>GG <esc>:exe('GGrep '.expand('<cword>'))<cr>

if (version >= 704)
  Plug 'haya14busa/incsearch.vim'
  set hlsearch
  let g:incsearch#auto_nohlsearch = 1
  let g:incsearch#is_stay = 1
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map n  <Plug>(incsearch-nohl-n)zz
  map N  <Plug>(incsearch-nohl-N)zz
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)
endif

Plug 'airblade/vim-gitgutter'

" syntax check
Plug 'scrooloose/syntastic'
nnoremap <leader>sc :SyntasticCheck<CR>

" appearance
Plug 'itchyny/lightline.vim'
Plug 'tomasr/molokai'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" binary editor
Plug 'Shougo/vinarise.vim'

" auto formatter
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

" rust
Plug 'rust-lang/rust.vim'

call plug#end()

" display
set showmatch
set number
set ruler
set cursorline
set showcmd

" indent
set smartindent
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab

" line
set wrap
if exists('+colorcolumn')
  set colorcolumn=80
endif

" disable backup
set nowritebackup
set nobackup
set noswapfile

" search
set smartcase
set infercase
set ignorecase
set hlsearch
set incsearch

" window
set splitbelow
set splitright

" etc
set hidden
set history=1000
set backspace=indent,eol,start
set modeline
set modelines=5
syntax on

" needed for lightline.vim
set laststatus=2
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ]
      \ }
      \ }

" colorschehme
set t_Co=256
set background=dark
colorscheme molokai
let g:molokai_original = 1

" encoding
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis

" default to verymagic when searching
nnoremap /  /\v
nnoremap ?  ?\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
nnoremap :g/ :g/\v
nnoremap :g// :g//

" other key bindings

" navigate through windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" more intuitive move of cursors when line is wraped around
nnoremap j gj
nnoremap k gk

" centralize when searching
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" disable unnecessary commands
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>
"nnoremap <Space> <Nop>

" for US Keyboard
noremap ; :
noremap : ;
noremap 0 ^
noremap ^ 0
