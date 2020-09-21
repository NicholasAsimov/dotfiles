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

" Folding
set foldmethod=syntax
set nofoldenable

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

" Map Y to act like D and C, i.e. to yank until EOL (which is more logical,
" but not Vi-compatible), rather than act as yy
nnoremap Y y$

" Faster split navigation using Alt+hjkl instead of Ctrl-W,hjkl
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Define commands to open terminal in a new split buffer

" Opens up a new buffer, either vertical or horizontal. Count can be used to
" specify the number of visible columns or rows.
fun! s:openBuffer(count, vertical)
  let cmd = a:vertical ? 'vnew' : 'new'
  let cmd = a:count ? a:count . cmd : cmd
  exe cmd
endf

" Opens a new terminal buffer, but instead of doing so using 'enew' (same
" window), it uses :vnew and :new instead. Usually, I want to open a new
" terminal and not replace my current buffer.
fun! s:openTerm(args, count, vertical)
  let params = split(a:args)

  call s:openBuffer(a:count, a:vertical)
  exe 'terminal' a:args
  exe 'startinsert'
endf

command! -count -nargs=* Term call s:openTerm(<q-args>, <count>, 0)
command! -count -nargs=* VTerm call s:openTerm(<q-args>, <count>, 1)

nmap <leader>z :Term<CR>

" Quickly close location and quickfix windows
nmap <leader>m :cclose<CR>:lclose<CR>

" Show completion menu even with only one element
" and don't select suggestion automatically
set completeopt=menuone,noselect

" Open new split panes to right and bottom
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
autocmd FileType go nmap <Leader>d  <Plug>(go-doc-browser) <bar> :echo "Opened in browser"<CR>
autocmd FileType go nmap <Leader>a  <Plug>(go-alternate-edit)
autocmd FileType go nmap <Leader>c  <Plug>(go-coverage-toggle)
autocmd FileType go setlocal ts=4 sts=4 sw=4 noexpandtab

" YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Vimrc
autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab

" Frontend
autocmd FileType javascript,typescript,html,css setlocal ts=2 sts=2 sw=2 expandtab

" Enable spellcheck for text files
autocmd FileType markdown,text,latex,tex setlocal spell

" Autosave file when running make
set autowrite

" Wayland clipboard provider that strips carriage returns (GTK3 issue).
" This is needed because currently there's an issue where GTK3 applications on
" Wayland contain carriage returns at the end of the lines (this is a root
" issue that needs to be fixed).
let g:clipboard = {
      \   'name': 'wayland-strip-carriage',
      \   'copy': {
      \      '+': 'wl-copy --foreground --type text/plain',
      \      '*': 'wl-copy --foreground --type text/plain --primary',
      \    },
      \   'paste': {
      \      '+': {-> systemlist('wl-paste --no-newline | tr -d "\r"')},
      \      '*': {-> systemlist('wl-paste --no-newline --primary | tr -d "\r"')},
      \   },
      \   'cache_enabled': 1,
      \ }

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
  call dein#add('tmsvg/pear-tree')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-unimpaired')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-abolish')
  call dein#add('tpope/vim-fugitive')
  call dein#add('jeffkreeftmeijer/vim-numbertoggle')
  call dein#add('justinmk/vim-dirvish')
  call dein#add('machakann/vim-highlightedyank')
  call dein#add('lambdalisue/suda.vim')
  call dein#add('AndrewRadev/splitjoin.vim')
  call dein#add('tommcdo/vim-lion')
  call dein#add('jaawerth/nrun.vim')

  " Async autocomplete
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/deoplete-lsp')

  " Language support
  call dein#add('neovim/nvim-lspconfig')
  call dein#add('fatih/vim-go', { 'hook_post_update': ':GoUpdateBinaries' })
  call dein#add('pangloss/vim-javascript')
  call dein#add('maxmellon/vim-jsx-pretty')
  call dein#add('leafgarland/typescript-vim')
  call dein#add('cespare/vim-toml')
  call dein#add('hashivim/vim-terraform')
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

" Don't automatically show identifier information
" because it conflicts with linting messages
let g:go_auto_type_info = 0

" Specify custom go fmt function
let g:go_fmt_command = "goimports"

let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'

let g:go_gopls_complete_unimported = 1
let g:go_diagnostics_enabled = 0

" Don't highlight diagnostics from gopls
let go_highlight_diagnostic_errors = 0
let go_highlight_diagnostic_warnings = 0

let g:go_doc_popup_window = 0

" =================================
" deoplete.nvim
" =================================

" Run deoplete.nvim automatically
let g:deoplete#enable_at_startup = 1

" Use omni completion for Go files (provided by vim-go)
" TODO replace vim-go completion with nvim-lsp?
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

" TODO can suggestion sorting work with gopls?
"let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" =================================
" ultisnips
" =================================

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" =================================
" neomake
" =================================

let g:neomake_highlight_columns = 0

" Disable showing error message next to the line of code
let g:neomake_virtualtext_current_error = 0

" Run neomake on buffer save
call neomake#configure#automake('w')

" Fira Mono doesn't have warning sign symbol (U+26A0) so use exclamation mark
let g:neomake_error_sign   = {'text': '!', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '!', 'texthl': 'NeomakeWarningSign'}

" javascript
let g:neomake_javascript_enabled_makers = ['eslint']
autocmd FileType javascript let b:neomake_javascript_eslint_exe = nrun#Which('eslint')

" typescript
let g:neomake_typescript_enabled_makers = ['tsc', 'eslint']

autocmd FileType typescript
      \ let b:neomake_typescript_tsc_exe = nrun#Which('tsc') |
      \ let b:neomake_typescript_eslint_exe = nrun#Which('eslint')

" go
let g:neomake_go_enabled_makers = ['go', 'golangci_lint']
let g:neomake_go_golangci_lint_args = ['run', '--out-format=line-number', '--print-issued-lines=false', '--config='.$HOME.'/.golangci.yml']

" =================================
" vim-jsx-pretty
" =================================

" This code is brought in from vim-jsx-pretty/autoload. It doesn't execute
" normally as pear-tree overrides it with it's own autoload file for
" javascript filetype.
augroup jsx_comment
  autocmd!
  autocmd FileType javascript let b:original_commentstring = &l:commentstring
  autocmd FileType javascript autocmd CursorMoved <buffer> call jsx_pretty#comment#update_commentstring(b:original_commentstring)
augroup END

" TODO less colorufl syntax? especially props

" =================================
" nvim-lsp
" =================================

lua << EOF

local nvim_lsp = require'nvim_lsp'

nvim_lsp.tsserver.setup{}
nvim_lsp.terraformls.setup{}

-- this 'do' block disables lsp diagnostics
do
  local method = 'textDocument/publishDiagnostics'
  local default_callback = vim.lsp.callbacks[method]
  vim.lsp.callbacks[method] = function(err, method, result, client_id)
    -- disable diagnostics
    do return end
    default_callback(err, method, result, client_id)
  end
end

EOF

" TODO add other LSP servers?
autocmd Filetype typescript,terraform call SetLSPOptions()

function SetLSPOptions()
  " Use LSP omni-completion.
  setlocal omnifunc=v:lua.vim.lsp.omnifunc

  nnoremap <buffer> <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
  nnoremap <buffer> <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <buffer> <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
  nnoremap <buffer> <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <buffer> <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <buffer> <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
  nnoremap <buffer> <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <buffer> <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
endfunction

" =================================
" fzf
" =================================

" :Rg command that searches hidden files
command! -bang -nargs=* MyRgHiddenFiles
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --hidden '.shellescape(<q-args>),
  \   1,
  \   <bang>0)

" :Rg command that doesn't include filename in the search filter
command! -nargs=* MyRgNoFilenames
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>),
  \   1,
  \   {'options': '--delimiter : --nth 2..'})

nnoremap <C-g>b :Buffers<CR>
" nnoremap <C-g>g :Rg<CR>
nnoremap <C-g>g :MyRgHiddenFiles<CR>
nnoremap <C-g>c :Commands<CR>
nnoremap <C-g>l :BLines<CR>
nnoremap <C-p> :Files<CR>

" Disable preview window
let g:fzf_preview_window = ''

" Use old default layout instead of popup window
let g:fzf_layout = { 'down': '40%' }

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

" Alias SudoWrite command
command SudoWrite SudaWrite

cmap w!! SudaWrite

" =================================
" pear-tree
" =================================

let g:pear_tree_repeatable_expand = 0
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

imap <Space> <Plug>(PearTreeSpace)

" =================================
" vim-lion
" =================================

let g:lion_squeeze_spaces = 1

" =================================
" vim-terraform
" =================================
let g:terraform_fmt_on_save = 1


" Get used to floating menu in wildmenu and remove this
set wildoptions=tagfile
