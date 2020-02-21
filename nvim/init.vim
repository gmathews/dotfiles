call plug#begin()
" Autocomplete
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'

" Indent lines
Plug 'nathanaelkane/vim-indent-guides'

" Toggle comments with gcc
Plug 'tomtom/tcomment_vim'

" For git blame and shit
Plug 'tpope/vim-fugitive'
" Indicate git changes on the side
Plug 'mhinz/vim-signify'

" Syntax checking
Plug 'w0rp/ale'

" Fancy file explorer
Plug 'scrooloose/nerdtree'

" Random syntax highlighting
Plug 'sheerun/vim-polyglot'

" Theme
Plug 'crusoexia/vim-monokai'

" Status line
Plug 'vim-airline/vim-airline'

"Fuzzy finding
Plug 'cloudhead/neovim-fuzzy'

Plug 'tmux-plugins/vim-tmux-focus-events'

" Format typescript automatically
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

call plug#end()

" deoplete tab-complete
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<tab>"
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<Up>"

" Setup theme
set termguicolors
set background=dark
colorscheme monokai

" Make commands easier
set showcmd
let mapleader=","

" Setup spelling
set spelllang=en_us
" Ruler to encourage files to have a fixed width
set colorcolumn=100

" Make commenting nicer
autocmd FileType * setlocal formatoptions-=r formatoptions-=o formatoptions+=j

" Setup Statusline
let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline_section_y = ""
let g:airline_section_x = ""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_min_count = 2
" let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#virtualenv#enabled = 0

" let g:deoplete#enable_at_startup = 1
" let g:deoplete#auto_complete_delay = 0
" let g:deoplete#auto_complete_start_length = 1
" let g:deoplete#enable_camel_case = 0
" let g:deoplete#enable_ignore_case = 0
" let g:deoplete#enable_refresh_always = 0
" let g:deoplete#enable_smart_case = 1
" let g:deoplete#file#enable_buffer_path = 1
" let g:deoplete#max_list = 10000
" " Ignore most sources
" let g:deoplete#sources = {}
" let g:deoplete#sources._ = ['LanguageClient']
" let g:deoplete#sources.cs = ['omni', 'LanguageClient']
" " Disable the candidates in Comment/String syntaxes.
" call deoplete#custom#source('_',
"             \ 'disabled_syntaxes', ['Comment', 'String'])
" Close preview when leaving insert or completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Nice things for editing
syntax on
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

" Highlight unwanted chars
set list
set listchars=tab:▸\ ,trail:▫,extends:→
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

filetype plugin indent on

if has('gui_running')
else
    set mouse=a
endif

" Automatically start language servers.
let g:LanguageClient_autoStart = 1
" Use Ale for linting
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_linters = {
            \ 'cs': ['OmniSharp'],
            \ 'php': ['langserver', 'psalm'],
            \ 'typescript': ['tslint', 'tsserver'],
            \}
let g:OmniSharp_highlight_types = 1
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
autocmd FileType cs setlocal noexpandtab
autocmd FileType cs setlocal nolist
let g:LanguageClient_diagnosticsEnable = 0
" let g:LanguageClient_loggingLevel = 'INFO'
" let g:LanguageClient_loggingFile =  expand('~/LanguageClient.log')
" let g:LanguageClient_serverStderr = expand('~/LanguageServer.log')

" Minimal LSP configuration for JavaScript
let g:LanguageClient_serverCommands = {}
if executable('javascript-typescript-stdio')
  let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
  " Use LanguageServer for omnifunc completion
  autocmd FileType javascript setlocal omnifunc=LanguageClient#complete
else
  echo "javascript-typescript-stdio not installed!\n"
  :cq
endif
" Minimal LSP configuration for c#
if executable('mono')
  let g:LanguageClient_serverCommands.cs = ['mono', '~/.omnisharp/OmniSharp.exe', '--languageserver']
  let g:LanguageClient_rootMarkers = {
              \ 'cs': ['*.sln'],
              \ }
else
  echo "omnisharp-roslyn not installed!\n"
endif
" Minimal LSP configuration for c/c++
if executable('clangd')
    let g:LanguageClient_serverCommands.cpp = ['clangd']
    autocmd FileType cpp setlocal omnifunc=LanguageClient#complete
else
  echo "clangd not installed!\n"
endif
if executable('php')
    let g:LanguageClient_serverCommands.php = ['php', '~/.composer/vendor/bin/php-language-server.php']
else
  echo "php not installed!\n"
endif
if executable('typescript-language-server')
    let g:LanguageClient_serverCommands.typescript = ['typescript-language-server', '--stdio']
    autocmd FileType typescript setlocal omnifunc=LanguageClient#complete
else
  echo "tsserver not installed!\n"
endif

" Autoformatting
let g:prettier#autoformat = 0
autocmd BufWritePre *.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.html PrettierAsync
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

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

" Node.js stuff
au BufNewFile,Bufread *.js set filetype=javascript
" au Filetype javascript setl sw=2 sts=2 et
let g:javascript_plugin_jsdoc = 1

" Python stuff
autocmd BufRead,BufNewFile *.py let python_highlight_all=1
let g:python3_host_prog = '/usr/local/bin/python3'
let g:loaded_python_provider = 1

" Setup signify
let g:signify_update_on_focusgained = 1

" Setup ident guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

" ripgrep
if executable('rg')
  " Use ripgrep over grep
  set grepprg=rg\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
endif

" Use Ag to grep and open the quickfix
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
" nnoremap \ :Ag<SPACE>

" No need for nerdtree?
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_winsize = 25
" let g:netrw_list_hide= '.*\.swp$,.*\.pyc$'
"
" " Manage toggle explorer
" let g:NetrwIsOpen=0
" function! ToggleNetrw()
"     if g:NetrwIsOpen
"         let i = bufnr("$")
"         while (i >= 1)
"             if (getbufvar(i, "&filetype") == "netrw")
"                 silent exe "bwipeout " . i
"             endif
"             let i-=1
"         endwhile
"         let g:NetrwIsOpen=0
"     else
"         let g:NetrwIsOpen=1
"         silent Lexplore
"     endif
" endfunction
"
" Setup nerdtree
let NERDTreeDirArrows=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Toggle nerd tree
function! ToggleNerdTree()
    if g:NERDTree.ExistsForTab()
        if !g:NERDTree.IsOpen()
            NERDTreeFind
        else
            call g:NERDTree.Close()
        endif
    else
        NERDTreeFind
    endif
endfunction

let NERDTreeIgnore = ['\.pyc$']

"Keymaps

" Fuzzy finder
map <leader>s :FuzzyOpen<CR>

" Explore symbols
map <leader>a :call LanguageClient#textDocument_documentSymbol()<CR>
map <leader>r :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>

" File explorer
" map <leader>e :call ToggleNetrw()<CR>
" map <leader>r :NERDTreeFind<CR>
" map <leader>r :NERDTreeToggle<CR>
map <leader>e :call ToggleNerdTree()<CR>

"Full file path to checkout files
nnoremap <leader>p :let @*=expand("%:p")<CR>
