" -----------------------------------------------------------------------------------------------------------
" NEOVIM CONFIGURATION | Author: nwj
" -----------------------------------------------------------------------------------------------------------

" PLUGIN SETUP
" -----------------------------------------------------------------------------------------------------------
"  Requires manual installation of junegunn/vim-plug
" https://github.com/junegunn/vim-plug#installation call plug#begin() call plug#begin()
call plug#begin() 

" Tree-based file explorer
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeFind', 'NERDTreeToggle'] }
" Lightweight and configurable status line
Plug 'itchyny/lightline.vim'
" Asynchronous fuzzy finder written in Go. Requires manual installation of fzf
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
" Asynchronous linting and make framework
Plug 'benekastah/neomake'
" Ag wrapper for project-wide search and editing
Plug 'dyng/ctrlsf.vim', { 'on': ['CtrlSF', 'CtrlSFToggle'] }
" Better commenting / uncommenting support
Plug 'tpope/vim-commentary', { 'on': 'Commentary' }
" Automatically save changes to disk
Plug '907th/vim-auto-save'
" Git wrapper
Plug 'tpope/vim-fugitive'
" Show a git diff in the line number gutter
Plug 'airblade/vim-gitgutter'
" Distraction-free writing mode
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

" Language-specific Syntax Plugins
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'neovimhaskell/haskell-vim'
Plug 'fatih/vim-go'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-git'
Plug 'keith/tmux.vim'

" Color schemes
Plug 'w0ng/vim-hybrid'
Plug 'cocopon/iceberg.vim'
Plug 'chriskempson/base16-vim'

call plug#end()

" GENERAL SETTINGS
" -----------------------------------------------------------------------------------------------------------
" Neovim's default settings: https://neovim.io/doc/user/vim_diff.html#nvim-option-defaults

set shell=/bin/zsh              " Requires manual installation of zsh
set hidden                      " Allows switching between unsaved buffers
set number                      " Enable line numbering
set clipboard=unnamed           " Allow use of the system clipboard
set scrolloff=10                " Start scrolling before reaching screen edge
set showmatch                   " Highlight matching parentheses and brackets
set synmaxcol=300               " Don't attempt to syntax highlight really long lines
set colorcolumn=110             " Display a grey bar at 110 columns to help show long lines
set wrapscan                    " Search again from the top when a search reaches the bottom

" Open splits below / to the right of the current pane. I just find this more intuitive
set splitbelow
set splitright

" Case insensitive search, unless the search pattern contains an uppercase character
set ignorecase
set smartcase

" Timeout on key codes but not mappings
set notimeout
set ttimeout
set ttimeoutlen=10

" Disable vim's built-in backup tools.
set nobackup
set nowb
set noswapfile

" Represent various 'invisible' whitespace characters with symbols
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,trail:·,nbsp:·

" Setup spell check
set spellfile=~/.config/nvim/dictionary.utf-8.add
set spelllang=en_us
set nospell 

" Conditionally enable true color support
if has('termguicolors')
  set termguicolors
endif

set background=dark
colorscheme hybrid

" NERDTREE SETTINGS
" -----------------------------------------------------------------------------------------------------------
" A more minimal UI
let g:NERDTreeMinimalUI = 1
let g:NERDTreeHighlightCursorline = 0
" Start with a wider NERDTree buffer
let g:NERDTreeWinSize = 57
" When a file is deleted, delete any matching buffers as well
let g:NERDTreeAutoDeleteBuffer = 1
" Show hidden files by default
let g:NERDTreeShowHidden = 1
" Ignore files set through wildignore
let g:NERDTreeRespectWildIgnore = 1

" LIGHTLINE SETTINGS
" -----------------------------------------------------------------------------------------------------------
" Minor changes here to trim down what's shown in the status line.
let g:lightline = {
      \ 'active': {
      \   'left': [['mode', 'paste'], ['readonly', 'filename']],
      \   'right': [['lineinfo'], ['percent'], ['filetype', 'fileencoding']]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"HELP":&readonly?"RO":""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&readonly)'
      \ },
      \ }

" FZF SETTINGS
" -----------------------------------------------------------------------------------------------------------
let g:fzf_layout = { 'left': '~40%' }

" NEOMAKE SETTINGS
" -----------------------------------------------------------------------------------------------------------
" Log errors only
let g:neomake_verbose = 0
" Adjust lint gutter signs
let g:neomake_warning_sign = {
      \ 'text': '❯',
      \ 'texthl': 'WarningMsg',
      \ }
let g:neomake_error_sign = {
      \ 'text': '❯',
      \ 'texthl': 'ErrorMsg',
      \ }
" Configure various linters
" Requires installation of ruby
let g:neomake_ruby_enabled_makers = ['mri']
" Requires installation of go
let g:neomake_go_enabled_makers = ['govet', 'go']

" CTRLSF SETTINGS
" -----------------------------------------------------------------------------------------------------------
"  Leave the ag results window open after interacting with it
let g:ctrlsf_auto_close = 0
" Reduce window size from 50% default
let g:ctrlsf_winsize = '40%'

" AUTO SAVE SETTINGS
" -----------------------------------------------------------------------------------------------------------
" Enable auto save
let g:auto_save = 1
" Suppress auto save messages
let g:auto_save_silent = 1
" Auto save whenever we leave insert mode and when text changes
let g:auto_save_events = ["InsertLeave", "TextChanged"]

" GITGUTTER SETTINGS
" -----------------------------------------------------------------------------------------------------------
" Disable gitgutter's key mappings
let g:gitgutter_map_keys = 0
" Increase the max signs from 500
let g:gitgutter_max_signs = 9999

" GO SETTINGS
" -----------------------------------------------------------------------------------------------------------
" Syntax highlighting for more things
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" Disable the autoformatter on save since it destroys undo history
let g:go_fmt_autosave = 0
" Turn off default key mappings
let g:go_def_mapping_enabled = 0
" Turn off various whitespace highlighting. We'll handle that with listchars
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_chan_whitespace_error = 0
let g:go_highlight_space_tab_error = 0
let g:go_highlight_trailing_whitespace_error = 0

" GENERAL KEY MAPPINGS
" -----------------------------------------------------------------------------------------------------------
" Set leader key
let g:mapleader = "\<space>"

" Unbind directional movement through a number of keys
nnoremap <up> <NOP>
nnoremap <down> <NOP>
nnoremap <left> <NOP>
nnoremap <right> <NOP>
nnoremap <bs> <NOP>
nnoremap <delete> <NOP>
inoremap <up> <NOP>
inoremap <down> <NOP>
inoremap <left> <NOP>
inoremap <right> <NOP>
nnoremap <Space> <NOP>
vnoremap <up> <NOP>
vnoremap <down> <NOP>
vnoremap <left> <NOP>
vnoremap <right> <NOP>
vnoremap <bs> <NOP>
vnoremap <delete> <NOP>
vnoremap <Space> <NOP>

" Unbind F1 (default behavior opens :help)
inoremap <F1> <NOP>
nnoremap <F1> <NOP>

" Unbind Q since exmode is just annoying
nnoremap Q <NOP>

" An easier way into command mode
nnoremap ; :
vnoremap ; :

" Easier window movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Make Y behave more like D, C, etc. (default behavior is effectively yy)
nnoremap Y y$

" More intuitive movement on lines that wrap
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Don't yank to default register when using change
nnoremap c "xc
xnoremap c "xc
nnoremap C "xC
xnoremap C "xC

" Easier buffer cycling
nnoremap <silent> + :bn<CR>
nnoremap <silent> _ :bp<CR>

" Don't cancel visual select when shifting
xnoremap <  <gv
xnoremap >  >gv

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Switch between the last two buffers
nnoremap <leader><leader> <c-^>

" Get write permission when you forget sudo
cnoremap w!! w !sudo tee %

" Expand file location of current buffer
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Toggle search highlighting
nnoremap <leader>l :set nohlsearch!<CR> :set nohlsearch?<CR>

" Toggle whitespace visibility
nnoremap <leader>; :set list!<CR> :set list?<CR>

" NERDTREE KEY MAPPINGS
" -----------------------------------------------------------------------------------------------------------
" Run NERDTreeFind or NerdTreeToggle based on current buffer
function! g:NerdWrapper() abort
  if &filetype ==# '' || expand('%:t') =~? 'NERD_tree'
    :NERDTreeToggle
  else
    :NERDTreeFind
  endif
endfunction
nnoremap <leader>o :call NerdWrapper()<CR>

" FZF KEY MAPPINGS
" -----------------------------------------------------------------------------------------------------------
" Run fuzzy file search
nnoremap <leader>u :Files<CR>
" Run fuzzy buffer search
nnoremap <leader>i :Buffers<CR>

" CTRLSF KEY MAPPINGS
" -----------------------------------------------------------------------------------------------------------
" Search the word under the cursor
nnoremap <leader>k :CtrlSF<CR>
" Start a project-wide search in command mode
nnoremap <leader>/ :CtrlSF<space>

" COMMENTARY KEY MAPPINGS
" -----------------------------------------------------------------------------------------------------------
" Comment / uncomment a line 
nnoremap <leader>j :Commentary<CR>
vnoremap <leader>j :Commentary<CR>

" GOYO KEY MAPPINGS
" -----------------------------------------------------------------------------------------------------------
" Toggle distraction-free mode
nnoremap <leader>p :Goyo<CR>

" AUTOCOMMANDS
" -----------------------------------------------------------------------------------------------------------
" Enable neomake
autocmd BufWritePost * Neomake
" Turn spell check on for markdown files
autocmd BufNewFile,BufRead *.md setlocal spell
