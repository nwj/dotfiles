" -----------------------------------------------------------------------------------------------------------
" NEOVIM CONFIGURATION | Author: nwj
" -----------------------------------------------------------------------------------------------------------

" PLUGIN SETUP
" -----------------------------------------------------------------------------------------------------------
" Requires manual installation of junegunn/vim-plug
" https://github.com/junegunn/vim-plug#installation
call plug#begin()

" Lightweight and configurable status line
Plug 'itchyny/lightline.vim'
" Asynchronous fuzzy finder written in Go.
" Requires manual installation of fzf (brew install fzf)
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
" Ag wrapper for project-wide search and editing
Plug 'dyng/ctrlsf.vim', { 'on': ['CtrlSF', 'CtrlSFToggle'] }
" Better commenting / uncommenting support
Plug 'tpope/vim-commentary', { 'on': 'Commentary' }
" Better paren and tag text objects
Plug 'tpope/vim-surround'
" Automatically save changes to disk
Plug '907th/vim-auto-save'
" Git wrapper
Plug 'tpope/vim-fugitive'
" Show a git diff in the line number gutter
Plug 'airblade/vim-gitgutter'
" Heuristic indentation detection
Plug 'tpope/vim-sleuth'
" Language-specific syntax plugins
Plug 'sheerun/vim-polyglot'
" Color schemes
Plug 'chriskempson/base16-vim'
Plug 'felixjung/vim-base16-lightline'
" Intellisense engine and specific language extensions
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-solargraph', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile'}

call plug#end()

" GENERAL SETTINGS
" -----------------------------------------------------------------------------------------------------------
" Neovim's default settings: https://neovim.io/doc/user/vim_diff.html#nvim-option-defaults

set shell=/bin/zsh              " Requires manual installation of zsh (brew install zsh)
set hidden                      " Allows switching between unsaved buffers
set number                      " Enable line numbering
set clipboard=unnamed           " Allow use of the system clipboard
set scrolloff=10                " Start scrolling before reaching screen edge
set showmatch                   " Highlight matching parentheses and brackets
set synmaxcol=300               " Don't attempt to syntax highlight really long lines
set colorcolumn=110             " Display a grey bar at 110 columns to help show long lines
set wrapscan                    " Search again from the top when a search reaches the bottom
set nowrap                      " Don't wrap long lines
set mouse=a                     " Turn on mouse support

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
colorscheme base16-oceanicnext

" Disable modeline support, since it's been a security vector in the past
set modelines=0
set nomodeline

" Fold based on language, fully expand all folds at start
set foldmethod=syntax
set nofoldenable

" LIGHTLINE SETTINGS
" -----------------------------------------------------------------------------------------------------------
" Minor changes here to trim down what's shown in the status line.
let g:lightline = {
      \ 'active': {
      \   'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'relativepath']],
      \   'right': [['lineinfo'], ['percent'], ['filetype', 'fileencoding']]
      \ },
      \ 'colorscheme': 'base16_oceanicnext',
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"HELP":&readonly?"RO":""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&readonly)'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" FZF SETTINGS
" -----------------------------------------------------------------------------------------------------------
let g:fzf_layout = { 'left': '~40%' }

" CTRLSF SETTINGS
" -----------------------------------------------------------------------------------------------------------
" Leave the ag results window open after interacting with it
let g:ctrlsf_auto_close = 0
let g:ctrlsf_regex_pattern = 1
let g:ctrlsf_auto_focus = {
    \ "at": "done",
    \ "duration_less_than": 1000
    \ }

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
" Always show the gutter
set signcolumn=yes
" Disable gitgutter's key mappings
let g:gitgutter_map_keys = 0
" Increase the max signs from 500
let g:gitgutter_max_signs = 9999
" How often gitgutter polls. Changed from 4000
set updatetime=300

" LANGUAGE SPECIFIC SETTINGS
" -----------------------------------------------------------------------------------------------------------
" Disable automatic formatting in elm
let g:elm_format_autosave = 0

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

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Switch between the last two buffers
nnoremap <leader><leader> <c-^>

" Get write permission when you forget sudo
cnoremap w!! w !sudo tee %

" Expand file location of current buffer
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" Toggle search highlighting
nnoremap <leader>. :set hlsearch!<CR>

" Toggle spell checking
nnoremap <leader>, :set spell!<CR>

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

" COC SETTINGS AND MAPPINGS
" -----------------------------------------------------------------------------------------------------------
" Trigger completion and navigate options using tab and shift-tab
call coc#config('suggest', {
\ 'autoTrigger': 'none',
\ })

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ coc#refresh()
inoremap <silent><expr> <S-TAB>
              \ pumvisible() ? "\<C-p>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ coc#refresh()

" Binding for jump to definition
nmap <leader>l <Plug>(coc-definition)

" Binding for autoformatting. Prefers prettier for supported filetypes.
command! -nargs=0 Prettier :CocCommand prettier.formatFile
augroup formatbinding
  autocmd! formatbinding
  autocmd Filetype go,elm nmap <buffer> <leader>m <Plug>(coc-format)
  autocmd Filetype html,css,scss,less,javascript,typescript,javascriptreact,json,yaml,markdown nmap <buffer> <leader>m :Prettier<CR>
augroup end

" Setup the elm language server
call coc#config("languageserver", {
  \ "elmLS": {
    \ "command": "elm-language-server",
    \ "filetypes": ["elm"],
    \ "rootPatterns": ["elm.json"],
    \ "initializationOptions": {
      \ "elmPath": "elm",
      \ "elmFormatPath": "elm-format",
      \ "elmTestPath": "elm-test",
      \ "elmAnalyseTrigger": "change"
    \ }
  \ }
\ })


" AUTOCOMMANDS
" -----------------------------------------------------------------------------------------------------------
" Turn spell check on for markdown files
autocmd BufNewFile,BufRead *.md setlocal spell

" Hide status line in FZF buffers
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
