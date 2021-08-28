-------------------------------------------------------------------------------------------------------------
-- NEOVIM CONFIGURATION | Author: nwj
-------------------------------------------------------------------------------------------------------------

-- PLUGIN SETUP
-------------------------------------------------------------------------------------------------------------
-- Requires manual installation of junegunn/vim-plug
-- https://github.com/junegunn/vim-plug#installation
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

-- Lua utility library
Plug 'nvim-lua/plenary.nvim'
-- Lightweight and configurable status line
Plug 'itchyny/lightline.vim'
-- Async fuzzy finder written in Lua
Plug 'nvim-telescope/telescope.nvim'
-- Ag wrapper for project-wide search and editing
Plug('dyng/ctrlsf.vim', {on = {'CtrlSF', 'CtrlSFToggle'}})
-- Better commenting / uncommenting support
Plug('tpope/vim-commentary', {on = 'Commentary'})
-- Better paren and tag text objects
Plug 'tpope/vim-surround'
-- Automatically save changes to disk
Plug '907th/vim-auto-save'
-- Show a git diff in the line number gutter
Plug 'lewis6991/gitsigns.nvim'
-- Heuristic indentation detection
Plug 'tpope/vim-sleuth'
-- Language-specific syntax plugins
Plug 'sheerun/vim-polyglot'
-- Color schemes
Plug 'chriskempson/base16-vim'
Plug 'mike-hearn/base16-vim-lightline'
-- Autoformatting
Plug 'sbdchd/neoformat'
-- Language server configuration
Plug 'neovim/nvim-lspconfig'
-- Completion menu
Plug 'hrsh7th/nvim-compe'

vim.call('plug#end')

-- LUA HELPERS
-------------------------------------------------------------------------------------------------------------
local opt = vim.opt
local g = vim.g
local fn = vim.fn
local cmd = vim.cmd

local map = function(keymap)
  local opts = {noremap = true}
  for key, val in pairs(keymap) do
    if type(key) == 'string' then opts[key] = val end
  end
  vim.api.nvim_set_keymap(keymap[1], keymap[2], keymap[3], opts)
end

-- GENERAL SETTINGS
-------------------------------------------------------------------------------------------------------------
-- Neovim's default settings: https://neovim.io/doc/user/vim_diff.html#nvim-option-defaults
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
opt.listchars = {tab = '▸ ', extends = '❯', precedes = '❮', trail = '·', nbsp = '·'}

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

-- LIGHTLINE SETTINGS
-------------------------------------------------------------------------------------------------------------
-- Minor changes here to trim down what's shown in the status line.
g.lightline = {
  colorscheme = 'base16_snazzy',
}

-- CTRLSF SETTINGS
-------------------------------------------------------------------------------------------------------------
-- Leave the ag results window open after interacting with it
g.ctrlsf_auto_close = 0
g.ctrlsf_regex_pattern = 1
g.ctrlsf_auto_focus = {
  at = 'done',
  duration_less_than = 1000
}

-- AUTO SAVE SETTINGS
-------------------------------------------------------------------------------------------------------------
-- Enable auto save
g.auto_save = 1
-- Suppress auto save messages
g.auto_save_silent = 1
-- Auto save whenever we leave insert mode and when text changes
g.auto_save_events = {'InsertLeave', 'TextChanged'}

-- GITSIGNS SETTINGS
-------------------------------------------------------------------------------------------------------------
require('gitsigns').setup {
  numhl = true,
  keymaps = {},
}
-- Always show the signs gutter
opt.signcolumn = 'yes'

-- NEOFORMAT SETTINGS
-------------------------------------------------------------------------------------------------------------
g.neoformat_enabled_css = {'prettier'}
g.neoformat_enabled_html = {'prettier'}
g.neoformat_enabled_javascript = {'prettier'}
g.neoformat_enabled_json = {'prettier'}
g.neoformat_enabled_less = {'prettier'}
g.neoformat_enabled_markdown = {'prettier'}
g.neoformat_enabled_rust = {'rustfmt'}
g.neoformat_enabled_typescript = {'prettier'}
g.neoformat_enabled_yaml = {'prettier'}

-- LANGUAGE SPECIFIC SETTINGS
-------------------------------------------------------------------------------------------------------------
-- Highlight markdown yaml frontmatter properly
g.vim_markdown_frontmatter = 1

-- Slightly better new line indentation when working on markdown lists
g.vim_markdown_new_list_item_indent = 0

-- GENERAL KEY MAPPINGS
-------------------------------------------------------------------------------------------------------------
-- Set leader key
vim.g.mapleader = ' '

-- Unbind directional movement through a number of keys
map {'n', '<up>', '<NOP>'}
map {'n', '<down>', '<NOP>'}
map {'n', '<left>', '<NOP>'}
map {'n', '<right>', '<NOP>'}
map {'n', '<bs>', '<NOP>'}
map {'n', '<delete>', '<NOP>'}
map {'i', '<up>', '<NOP>'}
map {'i', '<down>', '<NOP>'}
map {'i', '<left>', '<NOP>'}
map {'i', '<right>', '<NOP>'}
map {'n', '<Space>', '<NOP>'}
map {'v', '<up>', '<NOP>'}
map {'v', '<down>', '<NOP>'}
map {'v', '<left>', '<NOP>'}
map {'v', '<right>', '<NOP>'}
map {'v', '<bs>', '<NOP>'}
map {'v', '<delete>', '<NOP>'}
map {'v', '<Space>', '<NOP>'}

-- Unbind F1 (default behavior opens :help)
map {'i', '<F1>', '<NOP>'}
map {'n', '<F1>', '<NOP>'}

-- Unbind Q since exmode is just annoying
map {'n', 'Q', '<NOP>'}

-- An easier way into command mode
map {'n', ';', ':'}
map {'v', ';', ':'}

-- Easier window movement
map {'n', '<C-h>', '<C-w>h'}
map {'n', '<C-j>', '<C-w>j'}
map {'n', '<C-k>', '<C-w>k'}
map {'n', '<C-l>', '<C-w>l'}

-- Make Y behave more like D, C, etc. (default behavior is effectively yy)
map {'n', 'Y', 'y$'}

-- More intuitive movement on lines that wrap
map {'n', 'j', 'gj'}
map {'n', 'k', 'gk'}
map {'v', 'j', 'gj'}
map {'v', 'k', 'gk'}

-- Don't yank to default register when using change
map {'n', 'c', '"xc'}
map {'x', 'c', '"xc'}
map {'n', 'C', '"xC'}
map {'x', 'C', '"xC'}

-- Easier buffer cycling
map {'n', '<silent> +', ':bn<CR>'}
map {'n', '<silent> _', ':bp<CR>'}

-- Keep the cursor in place while joining lines
map {'n', 'J', 'mzJ`z'}

-- Switch between the last two buffers
map {'n', '<leader><leader>', '<c-^>'}

-- Get write permission when you forget sudo
map {'c', 'w!!', 'w !sudo tee %'}

-- Expand file location of current buffer
map {'c', '%%', "<C-R>=expand('%:h').'/'<CR>"}

-- Toggle search highlighting
map {'n', '<leader>.', ':set hlsearch!<CR>'}

-- Toggle spell checking
map {'n', '<leader>,', ':set spell!<CR>'}

-- CTRLSF KEY MAPPINGS
-------------------------------------------------------------------------------------------------------------
-- Search the word under the cursor
map {'n', '<leader>k', ':CtrlSF<CR>'}
-- Start a project-wide search in command mode
map {'n', '<leader>/', ':CtrlSF<space>'}

-- COMMENTARY KEY MAPPINGS
-------------------------------------------------------------------------------------------------------------
-- Comment / uncomment a line
map {'n', '<leader>j', ':Commentary<CR>'}
map {'v', '<leader>j', ':Commentary<CR>'}

-- NEOFORMAT KEY MAPPINGS
-------------------------------------------------------------------------------------------------------------
map {'n', '<leader>m', ':Neoformat<CR>'}

-- TELESCOPE KEY MAPPINGS
-------------------------------------------------------------------------------------------------------------
map {'n', '<leader>u', ':Telescope find_files<CR>'}
map {'n', '<leader>i', ':Telescope buffers<CR>'}

-- LSP SETUP
-------------------------------------------------------------------------------------------------------------
local lsp = require 'lspconfig'

lsp.rust_analyzer.setup {flags = {debounce_text_changes = 150}}
lsp.tsserver.setup {flags = {debounce_text_changes = 150}}
lsp.solargraph.setup {flags = {debounce_text_changes = 150}}

-- Binding for jump to definition
map {'n', '<leader>l', '<cmd>lua vim.lsp.buf.definition()<CR>'}

-- COMPE SETUP
-------------------------------------------------------------------------------------------------------------
require'compe'.setup {
  autocomplete = false,
  source = {
    path = true,
    buffer = true,
    spell = true,
    nvim_lsp = true
  }
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = fn.col('.') - 1
  return col == 0 or fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
_G.tab_complete = function()
  if fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

map {"i", "<Tab>", "v:lua.tab_complete()", expr = true}
map {"s", "<Tab>", "v:lua.tab_complete()", expr = true}
map {"i", "<S-Tab>", "v:lua.s_tab_complete()", expr = true}
map {"s", "<S-Tab>", "v:lua.s_tab_complete()", expr = true}

-- AUTOCOMMANDS
-------------------------------------------------------------------------------------------------------------
-- Turn spell check on for markdown files
cmd 'autocmd BufNewFile,BufRead *.md setlocal spell'

-- Enable line wrapping for markdown files
cmd 'autocmd BufNewFile,BufRead *.md setlocal wrap'
cmd 'autocmd BufNewFile,BufRead *.md setlocal linebreak'
