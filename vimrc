set nocompatible               " be iMproved
set encoding=utf-8

filetype off                  " required for vundle
" Set up vundle to manage bundles
call plug#begin()
" Fancy status bar
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Fancy file explorer
Plug 'scrooloose/nerdtree'
" Tag explorer
Plug 'majutsushi/tagbar'
" Awesome comment/uncomment support
Plug 'tomtom/tcomment_vim'
" Fuzzy file finder
Plug 'ctrlpvim/ctrlp.vim'
" For git blame and shit
Plug 'tpope/vim-fugitive'
" Indicate git changes on the side
Plug 'mhinz/vim-signify'
" Syntax checker
" Plug 'neomake/neomake'
Plug 'vim-syntastic/syntastic'

" Indent lines
Plug 'nathanaelkane/vim-indent-guides'
" Better find in files
Plug 'mileszs/ack.vim'

" Colorscheme
Plug 'morhetz/gruvbox'

" JS highlighting
Plug 'pangloss/vim-javascript'
" This is for nicer autocompletion
" Shit breaks all the time because python on OSX sucks

" Personal wiki
Plug 'vimwiki/vimwiki'

" Random syntax highlighting
Plug 'sheerun/vim-polyglot'

" Python stuff
Plug 'hynek/vim-python-pep8-indent'
call plug#end()

" Filetype stuff
filetype plugin indent on

set t_Co=256

" Colors
set background=dark
" colorscheme solarized
colorscheme gruvbox

" Stuff to do when we start in gui mode
if has('gui_running')
    " set guifont=Hack\ Regular:h12
    set macligatures
    set guifont=Fira\ Code:h12
    set guioptions-=T   " no toolbar
    set guioptions-=rL  " no scrollbars

    "set fu " Start in full screen
else
    set mouse=a
endif

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
set nobackup
set nowritebackup
set noswapfile
set title         "set our window/terminal title
set shortmess+=I
set cursorline

" Make commands easier
set showcmd
let mapleader=","

" Setup spelling
set spell spelllang=en_us
" Ruler to encourage files to have a fixed width
set colorcolumn=100

set foldmethod=indent
" how far in are folds closed by default
set foldlevel=90

" Make commenting nicer
autocmd FileType * setlocal formatoptions-=r formatoptions-=o formatoptions+=j

" Setup ident guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

" Highlight unwanted chars
set list
set listchars=tab:▸\ ,trail:▫,extends:→
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Show a navigable menu for tab completion
set wildmenu
set wildmode=longest,list,full

" Enable and setup powerline
set laststatus=2

let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline_section_y = ""
let g:airline_section_x = ""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_min_count = 2
" let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#virtualenv#enabled = 0

" Setup nerdtree
" map <leader>r :NERDTreeFind<CR>
" map <leader>r :NERDTreeToggle<CR>
map <leader>r :call ToggleNerdTree()<CR>

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

" Setup tagbar
map <leader>a :TagbarToggle<CR>
let g:tagbar_compact = 1

" Use our hidden ctags
set tags=./.tags;/
let g:gutentags_ctags_tagfile = '.tags'

" Setup ctrlP
map <leader>s :CtrlP<CR>
" This isn't used if we use ag
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]((node_modules|target|dist|bin|obj)|(\.(git|hg|svn)))$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" We don't want to have sub modules override our search, only use the current working directory.
" Add 'r' to use the parent git repo as the root
let g:ctrlp_working_path_mode = 0
" Use the silver searcher
if executable("ag")
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ackprg = 'ag --vimgrep'
endif

" Setup fugitive
" map <leader>gd :Gdiff<CR>
" map <leader>gb :Gblame<CR>

let g:javascript_plugin_jsdoc = 1

" Suppress YCM imp module warning
silent! py3 pass
" Setup you complete me
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_auto_trigger = 1
let g:ycm_csharp_server_port = 2000
let g:ycm_auto_stop_csharp_server = 0
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_semantic_triggers = {'haskell' : ['.']}
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Setup signify
let g:signify_update_on_focusgained = 1

" Mocha error messages
let &errorformat = '%E%.%#Error: %m,'
let &errorformat .= '%C%.%#at %s (%f:%l:%c),'
let &errorformat .= '%Z%.%#at %s (%f:%l:%c),'
let &errorformat .= '%-G%.%#,'

autocmd BufRead,BufNewFile *.py let python_highlight_all=1

" Setup wiki
let g:vimwiki_list = [{'path': '~/Dropbox/wiki/', 'auto_toc': 1,
            \ 'ext': '.md',
            \ 'syntax': 'markdown'}]
" let g:vimwiki_list = [{'path': '~/Dropbox/wiki/', 'auto_toc': 1, 'auto_export': 0,
"             \ 'ext': '.md',
"             \ 'syntax': 'markdown'
"             \ 'template_path': '~/Dropbox/wiki/templates', 'template_default': 'default',
"             \ 'template_ext': '.html'}]

" Setup omnisharp
let g:OmniSharp_selector_ui = 'ctrlp'
let g:OmniSharp_server_path = '~/.omnisharp/OmniSharp.exe'
let g:OmniSharp_host = "http://localhost:2000"
let g:syntastic_cs_checkers = ['code_checker']
let g:syntastic_python_checkers = ['flake8']
" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_javascript_eslint_exe = 'npm run lint --'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = []

function! CheckJavaScriptLinter(filepath, linter)
	if exists('b:syntastic_checkers')
		return
	endif
	if filereadable(a:filepath)
		let b:syntastic_checkers = [a:linter]
		let {'b:syntastic_' . a:linter . '_exec'} = a:filepath
	endif
endfunction

function! SetupJavaScriptLinter()
	let l:current_folder = expand('%:p:h')
	let l:bin_folder = fnamemodify(syntastic#util#findFileInParent('package.json', l:current_folder), ':h')
	let l:bin_folder = l:bin_folder . '/node_modules/.bin/'
	call CheckJavaScriptLinter(l:bin_folder . 'standard', 'standard')
	call CheckJavaScriptLinter(l:bin_folder . 'eslint', 'eslint')
endfunction

autocmd FileType javascript call SetupJavaScriptLinter()

let g:OmniSharp_server_type = 'roslyn'
let g:Omnisharp_start_server = 0
let g:Omnisharp_stop_server = 0

" Node.js stuff
au Filetype javascript setl sw=2 sts=2 et

augroup omnisharp_commands
    autocmd!

    autocmd FileType cs setlocal noexpandtab
    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

    " Synchronous build (blocks Vim)
    "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
    " Builds can also run asynchronously with vim-dispatch installed
    autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
    " automatic syntax check on events (TextChanged requires Vim 7.4)
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Automatically add new cs files to the nearest project on save
    " autocmd BufWritePost *.cs call OmniSharp#AddToProject()

    "show type information automatically when the cursor stops moving
    " autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    "The following commands are contextual, based on the current cursor position.

    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
    "finds members in the current buffer
    autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
    " cursor can be anywhere on the line containing an issue
    autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
    autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    "navigate up by method/property/field
    autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
    "navigate down by method/property/field
    autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

augroup END
