" ------------------------------------------------------------------------
" .VIMRC
" by nwj
" ------------------------------------------------------------------------

" GENERAL SETTINGS
" ------------------------------------------------------------------------
set nocompatible
set hidden
set scrolloff=10
set showcmd
set history=1000
set backspace=indent,eol,start
set showmatch
set encoding=utf-8
" This will make p,dd,yy,etc. just work with the OS X clipboard.
set clipboard=unnamed

" UI / APPEARANCE
" ------------------------------------------------------------------------
set number
set relativenumber
set ruler
set background=dark
" Show a grey line at 110 characters, which is where github's code viewer
" starts to scroll
set colorcolumn=110

" TABS, INDENTS, WRAPPING
" ------------------------------------------------------------------------
" We don't want smartindent here because we use filetype-based indentation.
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set shiftround
set nowrap

" WHITESPACE
" ------------------------------------------------------------------------
" Taken together, these settings highlight trailing whitespace on lines.
set list
set listchars=""
set listchars=tab:\ \
set listchars+=trail:.
set listchars+=extends:>
set listchars+=precedes:<

" SEARCH
" ------------------------------------------------------------------------
" When 'ignorecase' and 'smartcase' are both on, if a pattern contains an
" uppercase letter, search is case sensitive, otherwise, it is not.
set ignorecase
set smartcase
set hlsearch

" SAVING & BACKUPS
" ------------------------------------------------------------------------
" git has rendered vim's built in backup tools obsolete. This disables them.
set nobackup
set nowb
set noswapfile

" This will autosave all buffers whenever vim loses focus.
:au FocusLost * silent! wa

" KEY BINDINGS
" ------------------------------------------------------------------------
nnoremap ; :
vnoremap ; :
nnoremap Y y$

let mapleader = ","

" shortcut to toggle search highlighting
nmap <leader>h :set hlsearch! hlsearch? <CR>

" expand file location of current buffer
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :e %%

" get write permission when you forget sudo
cmap w!! w !sudo tee %

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Intuitive movement on lines that wrap
map j gj
map k gk

" Disable ex-mode keybinding because it's annoying and no one uses it.
:map Q <Nop>

" PLUGIN SETUP
" ------------------------------------------------------------------------
call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'ervandew/supertab'
Plug 'tpope/vim-commentary', { 'on': 'Commentary' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Shougo/unite.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'gabesoft/vim-ags', { 'on': 'Ags' }

" Language-specific Plugins
Plug 'benekastah/neomake'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' } | Plug 'AndrewRadev/vim-eco', { 'for': 'coffee' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'bitc/vim-hdevtools', { 'for': 'haskell' }

call plug#end()

" PLUGIN KEY BINDINGS
" ------------------------------------------------------------------------
" Unite.vim keybindings
nnoremap <silent> <c-p> :Unite -buffer-name=files -no-split -start-insert file_rec/neovim<CR>
nnoremap <leader>m :Unite -buffer-name=buffer -no-split buffer<CR>

" keybinding to comment stuff
map <leader>/ :Commentary<CR>

" keybinding to ag whatever word is currently under the cursor
nnoremap <leader>. :Ags "\b<C-R><C-W>\b"<CR>:cw<Cr>

" nerd tree keybinding
map <leader>n :NERDTreeToggle <CR>

" solarized background toggle keybinding
call togglebg#map("<F5>")

" PLUGIN-SPECIFIC
" ------------------------------------------------------------------------
colorscheme solarized
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
let g:unite_prompt = '>> '
let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
let g:gitgutter_max_signs = 1000
let g:neomake_javascript_enabled_makers = ['jshint']
let g:neomake_coffeescript_enabled_makers = ['coffeelint']
let g:neomake_ruby_enabled_makers = ['mri']
let g:neomake_haskell_enabled_makers = ['hdevtools']
autocmd! BufWritePost * Neomake

" FILETYPE DETECTION
" ------------------------------------------------------------------------
filetype plugin indent on
syntax enable

" LANGUAGE SPECIFIC SETTINGS
" ------------------------------------------------------------------------
" Ruby
autocmd BufNewFile,BufReadPost *.rb setl shiftwidth=2 softtabstop=2 expandtab
" CoffeeScript
autocmd BufNewFile,BufReadPost *.coffee* setl shiftwidth=2 softtabstop=2 expandtab
" HTML
autocmd BufNewFile,BufReadPost *.html* setl shiftwidth=2 softtabstop=2 expandtab
