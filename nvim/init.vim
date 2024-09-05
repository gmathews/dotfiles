
" Plugins {{{
call plug#begin()
" Fuzzy finding
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.3' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

" Better syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP setup/support
Plug 'neovim/nvim-lspconfig'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

" Linter for non LSP linting
Plug 'mfussenegger/nvim-lint'

" Theme
Plug 'ellisonleao/gruvbox.nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'glepnir/zephyr-nvim'

" Indent lines
Plug 'lukas-reineke/indent-blankline.nvim'

" Fancy file explorer
Plug 'nvim-tree/nvim-web-devicons' " for file icons
Plug 'nvim-tree/nvim-tree.lua'

" Code outline
Plug 'simrat39/symbols-outline.nvim'

" For git blame and shit
Plug 'tpope/vim-fugitive'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'akinsho/git-conflict.nvim'

" Toggle comments with gcc
Plug 'numToStr/Comment.nvim'

" Nicer folds
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'

" Status line
Plug 'nvim-lualine/lualine.nvim'
call plug#end()
" }}}

" Colors {{{
syntax on
set termguicolors
set background=dark
" let g:material_style = "oceanic"
" let g:gruvbox_material_background = 'hard'
" let g:gruvbox_material_better_performance = 1
" let g:gruvbox_material_statusline_style = 'original'
" let g:gruvbox_material_palette = 'orginal'
colorscheme gruvbox

" Highlight unwanted chars
" set list
" set listchars=tab:▸\ ,trail:▫,extends:→
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Ruler to encourage files to have a fixed width
set colorcolumn=100
" }}}

" Vim options {{{
" Make commands easier
set showcmd
let mapleader=","

" Setup spelling
set spelllang=en_us
" set spell
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell

" Make commenting nicer
autocmd FileType * setlocal formatoptions-=r formatoptions-=o formatoptions+=j

" Nice things for editing
set number
set hidden
set wrap        " wrap lines
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
"set smartindent
"set copyindent    " copy the previous indentation on autoindenting
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
"set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set expandtab     " <TAB> inserts spaces
set tabstop=4     " a tab is four spaces
set softtabstop=4 " when hitting <BS>, pretend like a tab is removed, even if spaces
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set clipboard=unnamed " yank and paste with the system clipboard
set autoread
" Refresh files if git changed them
au FocusGained * :checktime
set nobackup
set nowritebackup
set noswapfile
set title         "set our window/terminal title
set shortmess+=I
set cursorline

" Show a navigable menu for tab completion
set wildmenu
set wildmode=longest,list,full

set completeopt=menuone,noselect

filetype plugin indent on

if has('gui_running')
else
    set mouse=a
endif

" Search within subfolders by default
set path+=**
" But ignore noise
set path-=.git,build,lib,node_modules,public,_site,third_party

" Ignore autogenerated files
set wildignore+=*.o,*.obj,*.pyc,*.meta
" Ignore source control
set wildignore+=.git
" Ignore lib/ dirs since the contain compiled libraries typically
set wildignore+=build,lib,node_modules,public,_site,third_party
" Ignore images and fonts
set wildignore+=*.gif,*.jpg,*.jpeg,*.otf,*.png,*.svg,*.ttf
" Ignore case when completing
set wildignorecase


" ripgrep
if executable('rg')
  " Use ripgrep over grep
  set grepprg=rg\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
endif

" LaTeX wordcount
:command Texcount !texcount '%'
" set foldcolumn=1
" set foldlevelstart=99
set foldlevel=99
set foldenable
"}}}

" LSP, completion & Treesitter {{{
lua <<EOF
-- LSP settings
local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true }
    --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format({async=true)' ]]
end

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

-- Enable the following language servers
local servers = {'tsserver', 'clangd', 'rust_analyzer', 'pyright' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        }
end
-- lspconfig.tsserver.setup({
--     handlers = {
--         ['textDocument/publishDiagnostics'] = function(...) end
--     },
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    float = { border = "single" },
})

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
        luasnip.lsp_expand(args.body)
    end,
    },
mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
        },
    ['<Tab>'] = function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else
        fallback()
    end
end,
['<S-Tab>'] = function(fallback)
if cmp.visible() then
    cmp.select_prev_item()
elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
else
    fallback()
end
    end,
    },
sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    },
}
require'nvim-treesitter.configs'.setup {
    ensure_installed = {"javascript", "jsdoc", "json", "lua", "vim", "typescript"},
highlight = {
enable = true,
},
indent = {
enable = true
}
  }
require("symbols-outline").setup {
    autofold_depth = 1,
    width = 10,
    auto_close = true
}
require('ufo').setup()
EOF
" }}}

" other lua setup calls {{{
lua <<EOF
require('Comment').setup()
require('lualine').setup {
    options = {
        theme = 'auto',
    },
    extensions = { {
        sections={
        lualine_a={
        function()
            return '"g?" for help'
        end,
        }}
        ,filetypes={'NvimTree'}}
    },
    sections = {
        lualine_c = { {'filename', path = 1} },
        lualine_x = {'filetype'},
        },
    tabline = {
        lualine_a = { {
            filetype_names = {
                TelescopePrompt = 'Telescope',
                NvimTree = 'File Explorer',
                },
            'buffers', hide_filename_extension = true, show_filename_only = false, mode = 4, max_length = vim.o.columns
        }}
        }
    }

require'nvim-tree'.setup {
    update_focused_file = {
    enable = true
    },
filters = {
    dotfiles = true,
    custom = {"node_modules"}
    }
}

require('gitsigns').setup()

require('git-conflict').setup {
    default_mappings = true, -- disable buffer local mapping created by this plugin
    default_commands = true, -- disable commands created by this plugin
    disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
    list_opener = 'copen', -- command or function to open the conflicts list
    highlights = { -- They must have background color, otherwise the default color will be used
        incoming = 'DiffAdd',
        current = 'DiffText',
    }
}
vim.api.nvim_create_autocmd('User', {
  pattern = 'GitConflictDetected',
  callback = function()
    vim.notify('Conflict detected in '..vim.fn.expand('<afile>'))
    vim.keymap.set('n', 'cww', function()
      engage.conflict_buster()
      create_buffer_local_mappings()
    end)
  end
})

require("ibl").setup {
    scope = {
        show_start = false,
        show_end = false,
        },
    }
require('telescope').load_extension('fzf')
-- lint setup
require('lint').linters_by_ft = {
    javascript = {'eslint',},
    typescript = {'eslint',}
    }

EOF
" }}}

autocmd InsertLeave,BufWinEnter,BufWritePost *.js lua require('lint').try_lint()
autocmd InsertLeave,BufWinEnter,BufWritePost *.ts lua require('lint').try_lint()
autocmd InsertLeave,BufWritePre *.ts lua vim.lsp.buf.format()
set updatetime=300
autocmd CursorHold *.ts lua vim.diagnostic.open_float(0,{scope="cursor", focus=false})
autocmd CursorHold *.js lua vim.diagnostic.open_float(0,{scope="cursor", focus=false})

" Keymaps {{{

" Fuzzy finder
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>

" File explorer
nnoremap <leader>e :NvimTreeToggle<CR>

" Symbol outline
nnoremap <leader>s :SymbolsOutline<CR>

" Git blame
command Gblame Git blame

"Full file path to checkout files
nnoremap <leader>p :let @*=expand("%:p")<CR>

" }}}

" vim:foldmethod=marker:foldlevel=0
