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
inoremap <Esc> <Nop>

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
cmap w!! w !sudo tee % > /dev/null

" Disable scratch window when auto-completing
set completeopt-=preview

" Open new split panes to right and bottom, which feels more natural than Vim’s default
set splitbelow
set splitright

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
autocmd FileType go setlocal ts=4 sts=4 sw=4 noexpandtab

" YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Bindings for fzf
nnoremap <C-g>b :Buffers<CR>
nnoremap <C-g>g :Ag<CR>
nnoremap <C-g>c :Commands<CR>
nnoremap <C-f>l :BLines<CR>
nnoremap <C-p> :Files<CR>

" Specify custom go fmt function for vim-go plugin
let g:go_fmt_command = "goimports"

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
execute 'set runtimepath+=' . s:dein_dir.'/repos/github.com/Shougo/dein.vim'

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " Let dein manage dein
  " Required:
  call dein#add('Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('fatih/vim-go', { 'hook_post_update': ':GoInstallBinaries' })
  call dein#add('SirVer/ultisnips')
  call dein#add('junegunn/fzf', { 'build': './install --bin', 'merged': 0 })
  call dein#add('junegunn/fzf.vim')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-surround')
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

