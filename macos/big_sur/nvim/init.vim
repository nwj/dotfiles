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
Plug '/opt/homebrew/opt/fzf' | Plug 'junegunn/fzf.vim'
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
Plug 'mike-hearn/base16-vim-lightline'
" Autoformatting
Plug 'sbdchd/neoformat'
" Intellisense engine and specific language extensions
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-solargraph', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile'}

call plug#end()

lua <<EOF
-- GENERAL SETTINGS
-------------------------------------------------------------------------------------------------------------
-- Neovim's default settings: https://neovim.io/doc/user/vim_diff.html#nvim-option-defaults
local opt = vim.opt
local fn = vim.fn
local cmd = vim.cmd

opt.shell = '/bin/zsh'              -- Requires manual installation of zsh (brew install zsh)
opt.hidden = true                   -- Allows switching between unsaved buffers
opt.number = true                   -- Enable line numbering
opt.clipboard = 'unnamed'           -- Allow use of the system clipboard
opt.scrolloff = 10                  -- Start scrolling before reaching screen edge
opt.showmatch = true                -- Highlight matching parentheses and brackets
opt.synmaxcol = 1000                -- Don't attempt to syntax highlight really long lines
opt.colorcolumn = {'110'}           -- Display a grey bar at 110 columns to help show long lines
opt.wrapscan = true                 -- Search again from the top when a search reaches the bottom
opt.wrap = false                    -- Don't wrap long lines
opt.mouse = 'a'                     -- Turn on mouse support

-- Open splits below / to the right of the current pane. I just find this more intuitive
opt.splitbelow = true
opt.splitright = true

-- Incremental search, case insensitive unless the search pattern contains an uppercase character
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Timeout on key codes but not mappings
opt.timeout = false
opt.ttimeout = true
opt.ttimeoutlen = 10

-- Disable vim's built-in backup tools.
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Represent various 'invisible' whitespace characters with symbols
opt.list = true
opt.listchars = 'tab:▸\t,extends:❯,precedes:❮,trail:·,nbsp:·'

-- Setup spell check
opt.spellfile = '~/.config/nvim/dictionary.utf-8.add'
opt.spelllang = 'en_us'
opt.spell = false

-- Conditionally enable true color support
if fn.has('termguicolors') == 1 then
  opt.termguicolors = true
end

opt.background = 'dark'
cmd 'colorscheme base16-snazzy'

-- Disable modeline support, since it's been a security vector in the past
opt.modelines = 0
opt.modeline = false

-- Fold based on language, fully expand all folds at start
opt.foldmethod = 'syntax'
opt.foldenable = false

EOF

" LIGHTLINE SETTINGS
" -----------------------------------------------------------------------------------------------------------
" Minor changes here to trim down what's shown in the status line.
let g:lightline = {
      \ 'active': {
      \   'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'relativepath']],
      \   'right': [['lineinfo'], ['percent'], ['filetype', 'fileencoding']]
      \ },
      \ 'colorscheme': 'base16_snazzy',
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
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

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

" NEOFORMAT SETTINGS
" -----------------------------------------------------------------------------------------------------------
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_elm = ['elm-format']
let g:neoformat_enabled_go = ['gofmt']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_json = ['prettier']
let g:neoformat_enabled_less = ['prettier']
let g:neoformat_enabled_markdown = ['prettier']
let g:neoformat_enabled_rust = ['rustfmt']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_yaml = ['prettier']

" LANGUAGE SPECIFIC SETTINGS
" -----------------------------------------------------------------------------------------------------------
" Disable automatic formatting in elm
let g:elm_format_autosave = 0

" Highlight markdown yaml frontmatter properly
let g:vim_markdown_frontmatter = 1

" Slightly better new line indentation when working on markdown lists
let g:vim_markdown_new_list_item_indent = 0

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
" Run fuzzy file search against the files tracked in git, falling back to all files if outside a git repo
function! GFilesFallback()
  let output = system('git rev-parse --show-toplevel')
  let prefix = get(g:, 'fzf_command_prefix', '')
  if v:shell_error == 0
    exec "normal :" . prefix . "GFiles\<CR>"
  else
    exec "normal :" . prefix . "Files\<CR>"
  endif
  return 0
endfunction
nnoremap <leader>u :call GFilesFallback()<CR>
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

" NEOFORMAT KEY MAPPINGS
" -----------------------------------------------------------------------------------------------------------
nnoremap <leader>m :Neoformat<CR>

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

" Enable line wrapping for markdown files
autocmd BufNewFile,BufRead *.md setlocal wrap
autocmd BufNewFile,BufRead *.md setlocal linebreak
