" Persistent undo
set undofile
set undodir=$HOME/.config/nvim/undo

set undolevels=1000
set undoreload=10000

:silent call system('mkdir -p ' . &undodir)

" Show existing tab with 4 spaces width
set tabstop=4

" When indenting with '>', use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab

" Set leader key
let mapleader = ","

" Disable arrow keys in normal, visual and operation-pending modes
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Disable arrow keys in insert mode
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Disable <Esc> key in Insert mode to force using <jj> instead
" inoremap <Esc> <Nop>

" <Enter> in normal mode will disable highlighting of current search.
" Note: it will not clear the search, so using <n> will jump to the next
" occurance and enable search highlighting back
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" Enter command mode by pressing <;>
nnoremap ; :

" Exit insert mode by pressing <jj>
inoremap jj <Esc>

" Allow to de-tab using Shift-Tab
inoremap <s-tab> <C-d>

" Save with sudo when file is read-only
"cmap w!! w !sudo tee % > /dev/null

" Disable scratch window when auto-completing
set completeopt-=preview

" Open new split panes to right and bottom, which feels more natural than Vim’s default
set splitbelow
set splitright

" Case-insensitive search
set ignorecase
set smartcase

" Use relative number line by default and automatically change to absolute
" number line if in insert mode or if vi loses focus.
" TODO maybe switch to github.com/jeffkreeftmeijer/vim-numbertoggle plugin
set number
set relativenumber

autocmd FocusLost * set norelativenumber
autocmd FocusGained * set relativenumber
autocmd WinLeave * set norelativenumber
autocmd WinEnter * set relativenumber

autocmd InsertEnter * set norelativenumber
autocmd InsertLeave * set relativenumber

" Language-specific options

" Go
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  :w<CR> <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>i  <Plug>(go-info)
autocmd FileType go setlocal ts=4 sts=4 sw=4 noexpandtab

" YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Bindings for fzf
nnoremap <C-g>b :Buffers<CR>
nnoremap <C-g>g :Ag<CR>
nnoremap <C-g>c :Commands<CR>
nnoremap <C-g>l :BLines<CR>
nnoremap <C-p> :Files<CR>

" Autosave file when running make
set autowrite

" Set ultisnips triggers
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Set colorscheme
colorscheme Tomorrow-Night-Eighties

" Install plugins
"dein Scripts-----------------------------

let s:dein_dir = expand('~/.cache/dein')

" Required:
execute 'set runtimepath+='.s:dein_dir.'/repos/github.com/Shougo/dein.vim'

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " Let dein manage dein
  " Required:
  call dein#add('Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('fatih/vim-go', { 'hook_post_update': ':GoInstallBinaries', 'on_ft': 'go' })
  call dein#add('SirVer/ultisnips')
  call dein#add('junegunn/fzf', { 'build': './install --bin', 'merged': 0 })
  call dein#add('junegunn/fzf.vim')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-surround')
  call dein#add('neomake/neomake')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('pangloss/vim-javascript')
  call dein#add('mxw/vim-jsx')

  " Async autocomplete
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-go', { 'build': 'make', 'on_ft': 'go' })

  " Syntax
  call dein#add('cespare/vim-toml')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

" Plugin settings

" vim-go
" Do not automatically show identifier information
" because it conflicts with linting messages
let g:go_auto_type_info = 0

" Specify custom go fmt function
let g:go_fmt_command = "goimports"

" deoplete.nvim
set completeopt+=noselect
" Run deoplete.nvim automatically
let g:deoplete#enable_at_startup = 1

" deoplete-go
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#json_directory = $HOME.'/.cache/deoplete/go/linux_amd64'

" neomake
autocmd! BufWritePost * Neomake
let g:neomake_javascript_eslint_exe = $PWD.'/node_modules/.bin/eslint'
let g:neomake_javascript_enabled_makers = ['eslint']

let g:neomake_go_enabled_makers = ['gometalinter']
let g:neomake_go_gometalinter_args = ['--disable-all', '--enable=errcheck']

" vim-jsx
let g:jsx_ext_required = 0
