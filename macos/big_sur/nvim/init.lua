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
Plug 'Pocco81/AutoSave.nvim'
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
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

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
require('autosave').setup {
  execution_message = '',
}

-- GITSIGNS SETTINGS
-------------------------------------------------------------------------------------------------------------
require('gitsigns').setup {
  numhl = true,
  keymaps = {},
}
-- Always show the signs gutter
opt.signcolumn = 'yes'

-- LANGUAGE-SPECIFIC SETTINGS
-------------------------------------------------------------------------------------------------------------
local lsp = require 'lspconfig'

-- MARKDOWN
g.neoformat_enabled_markdown = {'prettier'}
g.vim_markdown_frontmatter = 1 -- Highlight markdown yaml frontmatter properly
g.vim_markdown_new_list_item_indent = 0 -- Slightly better new line indentation on lists
cmd 'autocmd BufNewFile,BufRead *.md setlocal spell' -- Turn spell check on for markdown files
cmd 'autocmd BufNewFile,BufRead *.md setlocal wrap' -- Enable line wrapping for markdown files
cmd 'autocmd BufNewFile,BufRead *.md setlocal linebreak'

-- HTML / CSS / JS
lsp.tsserver.setup {flags = {debounce_text_changes = 150}}
g.neoformat_enabled_html = {'prettier'}
g.neoformat_enabled_css = {'prettier'}
g.neoformat_enabled_javascript = {'prettier'}
g.neoformat_enabled_typescript = {'prettier'}
g.neoformat_enabled_json = {'prettier'}

-- RUST
lsp.rust_analyzer.setup {flags = {debounce_text_changes = 150}}
g.neoformat_enabled_rust = {'rustfmt'}

-- RUBY
lsp.solargraph.setup {flags = {debounce_text_changes = 150}}

-- YAML
g.neoformat_enabled_yaml = {'prettier'}

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

-- LSP KEY MAPPINGS
-------------------------------------------------------------------------------------------------------------
-- Binding for jump to definition
map {'n', '<leader>l', '<cmd>lua vim.lsp.buf.definition()<CR>'}

-- COMPE SETUP
-------------------------------------------------------------------------------------------------------------
local cmp = require'cmp'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup {
  completion = {
    autocomplete = false,
  },
  sources = {
    {name = 'nvim_lsp'},
    {name = 'path'},
    {name = 'buffer'},
  },
  mapping = {
   ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {"i", "s"}),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      end
    end, {"i", "s"}),
  },
}

cmp.setup.cmdline('/', {
  sources = {
    {name = 'buffer'},
  }
})
