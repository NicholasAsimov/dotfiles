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

" <Enter> in normal mode will disable highlighting of current search.
" Note: it will not clear the search, so using <n> will jump to the next
" occurance and enable search highlighting back
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" Enter command mode by pressing <;>
nnoremap ; :

" Exit insert mode by pressing <jj>
inoremap jj <Esc>

" Use relative number line by default and automatically change to absolute
" number line if in insert mode or if vi loses focus.
" TODO maybe switch to github.com/jeffkreeftmeijer/vim-numbertoggle plugin
set number
set relativenumber

" TODO focuslost doesn't wors
autocmd FocusLost * set norelativenumber
autocmd FocusGained * set relativenumber
autocmd WinLeave * set norelativenumber
autocmd WinEnter * :set relativenumber

autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" Bindings to build and run programs
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" Specify custom go fmt function for vim-go plugin
let g:go_fmt_command = "goimports"

" Autosave file when running make
set autowrite

" Set colorscheme
colorscheme Tomorrow-Night-Eighties

" Install plugins
"dein Scripts-----------------------------
" Required:
set runtimepath+=/home/rockstar/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/rockstar/.cache/dein')
  call dein#begin('/home/rockstar/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/rockstar/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('fatih/vim-go')
  " You can specify revision/branch/tag.
  " call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

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

