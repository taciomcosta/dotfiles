" Indenting
filetype plugin indent on
set shiftwidth=0
set tabstop=4
set softtabstop=4
set expandtab
set autoindent
set noexpandtab

" Set ruler
"set colorcolumn=80
set colorcolumn=120
set cursorline

" <leader>
let mapleader=","

"Relative line numbers
set rnu

" set encoding for devicons
set encoding=UTF-8

let g:newtr_liststyle=3

call plug#begin()
    Plug 'preservim/nerdtree'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-airline/vim-airline'
    Plug 'tomasiser/vim-code-dark'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	
	Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
 
	Plug 'preservim/nerdcommenter'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'
    Plug 'liuchengxu/vista.vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'Mofiqul/vscode.nvim'
	Plug 'morhetz/gruvbox', {'as': 'gruvbox' }
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	" autocompletion with nvim-comp
	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-vsnip'
	Plug 'hrsh7th/vim-vsnip'
call plug#end()

" Theme
colorscheme gruvbox

" Bindings
nnoremap <silent> <expr> <C-n> :NERDTreeFind<CR>
nnoremap <Leader>s :Vista nvim_lsp<CR>
nnoremap <silent> <C-p> :Telescope find_files<CR>
nnoremap <Leader>f :Telescope grep_string<CR>
nnoremap <Leader>v :tabnew $MYVIMRC<CR>
nnoremap <Leader>n :cn <CR>
nnoremap <Leader>N :cp <CR>

"""" Nerdtree
nmap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize = 50

"""" vim-arline
let g:airline#extensions#branch#enabled=1
let g:airline_theme = 'codedark'

""" Fugitive
function! ToggleGStatus()
	if buflisted(bufname('.git/index'))
		bd .git/index
	else
		rightbelow Git status
	endif
endfunction
nnoremap <C-g> :call ToggleGStatus()<CR>
nnoremap <C-d> :vertical Gdiffsplit<CR>

""" LSP
lua << EOF
require'lspconfig'.gopls.setup{
	cmd = {"gopls", "--remote=auto"},
	settings = {
	  gopls = {
		analyses = {
		  unusedparams = true
		},
		staticcheck = true,
		buildFlags = {"-tags=integration,unit"}
	  },
	},
}

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
end
EOF

""" Treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  ignore_install = {},
  highlight = {
	enable = true,
	disable = {},
	additional_vim_regex_highlighting = false,
  },
}
EOF

""" nvim-comp
set completeopt=menu,menuone,noselect

lua <<EOF
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    mapping = {
	  ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
	  ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<C-y>'] = cmp.config.disable,
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  require('lspconfig').gopls.setup {
    capabilities = capabilities
  }
EOF


""" LSP
nnoremap <silent> gD <Cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gd <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <Leader>wa <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
nnoremap <silent> <Leader>wr <cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
nnoremap <silent> <Leader>wl <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
nnoremap <silent> <Leader>D <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <Leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <Leader>qf <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <space>e <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> [g <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> ]g <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <space>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> <space>f <cmd>lua vim.lsp.buf.formatting()<CR>

highlight LspDiagnosticsDefaultError guifg=Red ctermfg=Red
highlight LspDiagnosticsUrderlineError guifg=Red ctermfg=Red
highlight LspDiagnosticsDefaultWarning guifg=Yellow ctermfg=Yellow
highlight LspDiagnosticsUnderlineWarning guifg=Yellow ctermfg=Yellow
