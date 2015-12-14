" ------------------------------------------------------------------------
" .VIMRC
" by nwj
" ------------------------------------------------------------------------

" Loads plugins. Must come first.
call pathogen#infect()
call pathogen#helptags()

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
colorscheme solarized
set guioptions-=T
set guifont=Monaco:h12
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

" ctrl-p keybinding
let g:ctrlp_map = "<c-p>"

" keybinding to ag whatever word is currently under the cursor
nnoremap <leader>. :Ag "\b<C-R><C-W>\b"<CR>:cw<Cr>

" bufexplorer keybinding
map <leader>m :ToggleBufExplorer <CR>

" nerd commenter keybinding
map <leader>/ <plug>NERDCommenterToggle

" nerd tree keybinding
map <leader>n :NERDTreeToggle <CR>

" solarized background toggle keybinding
call togglebg#map("<F5>")

" PLUGIN-SPECIFIC
" ------------------------------------------------------------------------
let g:ctrlp_working_path_mode = 0
let g:ctrlp_switch_buffer = 0
let g:ctrlp_user_command = '/usr/local/bin/ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_match_window = 'bottom, order:btt, min:1, max:20, results:20'
let g:agprg="/usr/local/bin/ag --column"
let g:gitgutter_max_signs = 1000

" FILETYPE DETECTION
" ------------------------------------------------------------------------
filetype plugin indent on
syntax enable

" LANGUAGE SPECIFIC SETTINGS
" ------------------------------------------------------------------------
" Ruby
autocmd BufNewFile,BufReadPost *.rb setl shiftwidth=2 softtabstop=2 expandtab
" CoffeeScript
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 softtabstop=2 expandtab
" HTML
autocmd BufNewFile,BufReadPost *.html* setl shiftwidth=2 softtabstop=2 expandtab
