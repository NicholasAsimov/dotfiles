" Enable 24-bit color
if has("termguicolors")
	set termguicolors
endif

" Disable cursor styling
set guicursor=

" Automatically enter insert mode in terminal buffer and hide number line
" This was default behavior until neovim 0.2.1
autocmd TermOpen * setlocal nonumber norelativenumber
autocmd TermOpen * startinsert

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

" Faster split navigation using Alt+hjkl instead of Ctrl-W,hjkl
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

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

" Interactive substitution
set inccommand=nosplit

" Use relative number line by default
set number
set relativenumber

" Language-specific options

" Go
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  :w<CR>:vsplit <bar> terminal go run %<CR>
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
  call dein#add('SirVer/ultisnips')
  call dein#add('junegunn/fzf', { 'build': './install --bin', 'merged': 0 })
  call dein#add('junegunn/fzf.vim')
  call dein#add('neomake/neomake')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-unimpaired')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-abolish')
  call dein#add('jeffkreeftmeijer/vim-numbertoggle')
  call dein#add('justinmk/vim-dirvish')
  call dein#add('machakann/vim-highlightedyank')
  call dein#add('lambdalisue/suda.vim')

  " Async autocomplete
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-go', { 'build': 'make', 'on_ft': 'go' })

  " Language support
  call dein#add('fatih/vim-go', { 'hook_post_update': ':GoInstallBinaries', 'on_ft': 'go' })
  call dein#add('pangloss/vim-javascript')
  call dein#add('mxw/vim-jsx')
  call dein#add('cespare/vim-toml')
  call dein#add('xuhdev/vim-latex-live-preview', { 'on_ft': 'tex' })

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

" =================================
" vim-go
" =================================

" Do not automatically show identifier information
" because it conflicts with linting messages
let g:go_auto_type_info = 0

" Specify custom go fmt function
let g:go_fmt_command = "goimports"

" =================================
" deoplete.nvim
" =================================

set completeopt+=noselect

" Run deoplete.nvim automatically
let g:deoplete#enable_at_startup = 1

" =================================
" deoplete-go
" =================================

let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" =================================
" neomake
" =================================

let g:neomake_highlight_columns = 0

" Run neomake on buffer save
call neomake#configure#automake('w')

" Fira Mono doesn't have warning sign symbol (U+26A0) so use exclamation mark
let g:neomake_warning_sign = {'text': '!', 'texthl': 'NeomakeWarningSign'}

" javascript eslint
let g:neomake_javascript_eslint_exe = $PWD.'/node_modules/.bin/eslint'
let g:neomake_javascript_enabled_makers = ['eslint']

" go
let g:neomake_go_enabled_makers = ['gometalinter']
let g:neomake_go_gometalinter_args = ['--disable-all', '--enable=vet', '--enable=golint', '--enable=errcheck', '--enable=gas', '--enable=megacheck', '--enable=misspell', '--enable=interfacer']

" =================================
" vim-jsx
" =================================

let g:jsx_ext_required = 0

" =================================
" fzf
" =================================

" Redefine :Ag command to use ignore file
command! -bang -nargs=* Ag
    \ call fzf#vim#ag(<q-args>,
    \   '--path-to-ignore ~/.ignore',
    \   <bang>0)

" =================================
" vim-latex-live-preview
" =================================

let g:livepreview_previewer = 'mupdf'

" =================================
" dirvish
" =================================

" Sort: directories at the top, alphabetical, case-sensitive
" Double sort reqired to make dot directories to be at the top
let g:dirvish_mode = ':sort | sort ,^.*/,'

" Disable netrw completely and override it's commands to dirvish
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore vsplit | silent Dirvish <args>

" Disable preview keybinds so they don't collide with fzf
augroup dirvish_config
    autocmd!
    autocmd FileType dirvish silent! unmap <buffer> <C-p>
    autocmd FileType dirvish silent! unmap <buffer> <C-n>
augroup END

" =================================
" suda.vim
" =================================

" Use sudo:// prefix instead of suda://
let g:suda#prefix = 'sudo://'

" Add SudoWrite command
command! -nargs=1 SudoWrite write sudo://<args>

