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

" Disable u keybind in visual mode that makes selected text lowercase
vmap u <Nop>

" Decrease CursorHold update time to quickly show diagnostics in echo line
" TODO this requires antoinemadec/FixCursorHold.nvim plugin to decouple updatetime from CursorHold
" This might not be needed later on, see also: https://neovim.discourse.group/t/psa-dont-rely-on-cursorhold-yet/1813
set updatetime=4000
let g:cursorhold_updatetime = 100

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
autocmd FileType go nmap <leader>e  :silent GoRun<CR>:echo<CR>
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
autocmd FileType javascript,typescript,typescriptreact,vue,html,css,scss setlocal ts=2 sts=2 sw=2 expandtab

" Enable spellcheck for text files
autocmd FileType markdown,text,latex,tex setlocal spell

" Autosave file when running make
set autowrite

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
  call dein#add('hrsh7th/nvim-compe')
  call dein#add('junegunn/fzf', { 'build': './install --bin', 'merged': 0 })
  call dein#add('junegunn/fzf.vim')
  call dein#add('nvim-treesitter/nvim-treesitter', {'hook_post_update': 'TSUpdate'})
  call dein#add('windwp/nvim-autopairs')
  call dein#add('windwp/nvim-ts-autotag')
  call dein#add('tpope/vim-commentary')
  call dein#add('Arelav/vim-context-commentstring', { 'rev': 'patch-1' })
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

  " Language support
  call dein#add('neovim/nvim-lspconfig')
  call dein#add('williamboman/nvim-lsp-installer')
  call dein#add('mfussenegger/nvim-lint')
  call dein#add('seblj/nvim-echo-diagnostics')
  call dein#add('antoinemadec/FixCursorHold.nvim')
  call dein#add('https://gitlab.com/yorickpeterse/nvim-dd.git')
  call dein#add('fatih/vim-go', { 'hook_post_update': ':GoUpdateBinaries' })
  call dein#add('pangloss/vim-javascript')
  call dein#add('maxmellon/vim-jsx-pretty')
  call dein#add('leafgarland/typescript-vim')
  call dein#add('leafOfTree/vim-vue-plugin')
  call dein#add('cespare/vim-toml')
  call dein#add('towolf/vim-helm')
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

" Disable all vim-go interaction with gopls in favor of nvim-lsp
" TODO replace remaing vim-go functionality and remove it, only syntax files are needed
" TODO https://github.com/ton/vim-alternate instead of GoAlternate
let g:go_gopls_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_echo_go_info = 0
let g:go_fmt_autosave = 0
let g:go_imports_autosave = 0
let g:go_diagnostics_level = 0
let g:go_highlight_diagnostic_errors = 0
let g:go_highlight_diagnostic_warnings = 0
let g:go_doc_popup_window = 0
let g:go_auto_type_info = 0
let g:go_info_mode = 'guru'

let g:go_debug = []

" =================================
" nvim-compe
" =================================

let g:compe = {
  \ 'enabled': v:true,
  \ 'autocomplete': v:true,
  \ 'debug': v:false,
  \ 'min_length': 2,
  \ 'preselect': 'disable',
  \ 'documentation': v:false,
  \
  \ 'source': {
    \ 'path': v:true,
    \ 'buffer': v:true,
    \ 'calc': v:false,
    \ 'nvim_lsp': v:true,
    \ 'nvim_lua': v:false,
    \ 'vsnip': v:false,
    \ 'ultisnips': v:true,
    \ 'luasnip': v:false,
    \ 'emoji': v:false,
  \ },
\ }

" =================================
" ultisnips
" =================================

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" =================================
" vim-jsx-pretty
" =================================

" TODO less colorufl syntax? especially props

" =================================
" nvim-lsp
" =================================

lua << EOF

-- Disable semantic highlighting
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end

-- Configure autopairs
local npairs = require'nvim-autopairs'
local Rule   = require'nvim-autopairs.rule'

npairs.setup{}

-- add spaces between parentheses
npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    end),
  Rule('( ', ' )')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%)') ~= nil
      end)
      :use_key(')'),
  Rule('{ ', ' }')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%}') ~= nil
      end)
      :use_key('}'),
  Rule('[ ', ' ]')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%]') ~= nil
      end)
      :use_key(']')
}

-- Configure Treesitter
require'nvim-treesitter.configs'.setup {
  -- TODO change to `ensure_installed = 'maintained',` after enabling treesitter highlighting
  -- currently treesitter is only used for auto tag closing in html, jsx
  ensure_installed = { 'javascript', 'html', 'tsx' },

  -- TODO configure treesitter highlighting and get rid of most vim highlight plugins (e.g. javascript, jsx etc.)
  highlight = {
    enable = false,
    disable = { 'c', 'rust' },
  },

  indent = {
    enable = false,
  },

  incremental_selection = {
    enable = false,
  },

  autotag = {
    enable = true,
  },
}

-- Configure diagnostics
vim.diagnostic.config({
  virtual_text = false,
  underline = false,
  update_in_insert = false,
})

local signs = {
	{ text = "!", name = "DiagnosticSignError" },
	{ text = "!", name = "DiagnosticSignWarn" },
	{ text = "!", name = "DiagnosticSignHint" },
	{ text = "!", name = "DiagnosticSignInfo" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

-- This plugin shows diagnostics in echo line
require("echo-diagnostics").setup{
    show_diagnostic_number = false,
    show_diagnostic_source = true,
}

-- This plugin defers diagnostics when editing
require('dd').setup({
  -- The time to wait before displaying newly produced diagnostics.
  timeout = 2000
})

-- disable diagnostics completely
--vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end

-- Configure LSP
local lsp_installer = require 'nvim-lsp-installer'

local servers = {
  'gopls',
  'eslint',
  'tsserver',
  'terraformls',
}

-- Set up buffer-local keymaps (vim.api.nvim_buf_set_keymap()), etc.
local function on_attach(client, bufnr)
end

-- Install required LSP servers automatically
for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print('Installing ' .. name)
    server:install()
  end
end

-- Provide server-specific settings
local enhance_server_opts = {
  ['gopls'] = function(opts)
    opts.settings = {
      gopls = {
        ['gofumpt'] = true,
        ['local'] = 'github.com/malwarebytes',
        ['linksInHover'] = false,
      }
    }
  end,

  ['tsserver'] = function(opts)
    opts.on_attach = function(client, bufnr)
      on_attach(client, bufnr)
    end
  end,

  ['eslint'] = function(opts)
    opts.on_attach = function(client, bufnr)
      on_attach(client, bufnr)
    end

    opts.settings = {
      format = { enable = true }, -- this will enable formatting
    }
  end,
}

lsp_installer.on_server_ready(function(server)
  -- Specify the default options which we'll use to setup all servers
  local opts = {
    on_attach = on_attach,
  }

  if enhance_server_opts[server.name] then
    -- Enhance the default opts with the server-specific ones
    enhance_server_opts[server.name](opts)
  end

  server:setup(opts)
end)

require('lint').linters_by_ft = {
  go = {'golangcilint',}
}

-- override notify to ignore `gopls -remote=auto` exiting with a non-zero exit code
local notify = vim.notify
vim.notify = function (msg, log_level, _opts)
if msg:match('exit code') then return end
  notify(msg, log_level, _opts)
end

function organizeImports(wait_ms)
  local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
  params.context = {only = {'source.organizeImports'}}
  local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

EOF

" TODO move to lua on_attach
autocmd Filetype go,typescript,typescriptreact,terraform call SetLSPOptions()

function SetLSPOptions()
  " Use LSP omni-completion.
  setlocal omnifunc=v:lua.vim.lsp.omnifunc

  augroup lsp
    autocmd! * <buffer>
    autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
    autocmd BufWritePre <buffer> lua organizeImports(1000)
    autocmd BufWritePost <buffer> lua require('lint').try_lint()
    autocmd CursorHold * lua require('echo-diagnostics').echo_line_diagnostic()
  augroup end

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

cmap w!! SudaWrite %

" =================================
" vim-lion
" =================================

let g:lion_squeeze_spaces = 1

" =================================
" vim-helm
" =================================

" Don't use vim-helm for yaml files (only .tpl)
autocmd BufRead,BufNewFile */templates/*.yaml set ft=yaml

" =================================
" vim-terraform
" =================================

let g:terraform_fmt_on_save = 1

" =================================
" vim-vue-plugin
" =================================

function! OnChangeVueSyntax(syntax)
  " echom 'Syntax is '.a:syntax
  if a:syntax == 'html'
    setlocal commentstring=<!--%s-->
    setlocal comments=s:<!--,m:\ \ \ \ ,e:-->
  elseif a:syntax =~ 'css'
    setlocal comments=s1:/*,mb:*,ex:*/ commentstring&
  else
    setlocal commentstring=//%s
    setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
  endif
endfunction

" =================================
" vim-vue-plugin
" =================================

function! OnChangeVueSyntax(syntax)
  " echom 'Syntax is '.a:syntax
  if a:syntax == 'html'
    setlocal commentstring=<!--%s-->
    setlocal comments=s:<!--,m:\ \ \ \ ,e:-->
  elseif a:syntax =~ 'css'
    setlocal comments=s1:/*,mb:*,ex:*/ commentstring&
  else
    setlocal commentstring=//%s
    setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
  endif
endfunction


" Get used to floating menu in wildmenu and remove this
set wildoptions=tagfile
