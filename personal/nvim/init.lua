-------------------------------------------------------------------------------------------------------------
-- NEOVIM CONFIGURATION | Author: nwj
-------------------------------------------------------------------------------------------------------------

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Basic settings
-- Default to use of the system clipboard
vim.opt.clipboard = "unnamedplus"
-- Enable line numbering
vim.opt.number = true
-- Always show the signs gutter
vim.opt.signcolumn = "yes"
-- Start scrolling before reaching screen edge
vim.opt.scrolloff = 10
-- Highlight matching parentheses and brackets
vim.opt.showmatch = true
-- Don't wrap long lines
vim.opt.wrap = false
-- Timeout on key codes but not mappings
vim.opt.timeout = false

-- Open splits below / to the right of the current pane. I just find this more intuitive
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Case insensitive search unless the search pattern contains an uppercase character
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Disable vim's built-in backup tools.
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Persist undo history across sessions, pruning it after 30 days
vim.opt.undofile = true
vim.fn.jobstart({ "find", vim.fn.stdpath("state") .. "/undo", "-type", "f", "-mtime", "+30", "-delete" })

-- Represent various 'invisible' whitespace characters with symbols
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", extends = "❯", precedes = "❮", trail = "·", nbsp = "·" }

-- Setup spell check
vim.opt.spelllang = "en_us"
vim.opt.spellfile = vim.fn.stdpath("config") .. "/dictionary.utf-8.add" -- words are added here via `zg` and removed via `zw`

-- Fold based on language, fully expand all folds at start
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

-- Disable modeline support, since it's been a security vector in the past
vim.opt.modelines = 0
vim.opt.modeline = false

-- Plugin initialization
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	-- Colorscheme setup
	{
		"EdenEast/nightfox.nvim",
		version = "^3.6.1",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme nightfox")
		end,
	},

	-- Other Colorschemes
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "folke/tokyonight.nvim" },
	{ "rebelot/kanagawa.nvim" },
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "sainnhe/everforest" },

	-- Lualine (Status Bar) setup
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		priority = 1000,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			sections = {
				lualine_c = { { "filename", path = 1 } },
			},
		},
	},

	-- Telescope (Fuzzy Picker) setup
	{
		"nvim-telescope/telescope.nvim",
		version = "^0.1.4",
		cmd = "Telescope",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
		opts = {
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
				},
				grep_string = {
					additional_args = { "--hidden" },
				},
				live_grep = {
					additional_args = { "--hidden" },
				},
			},
			defaults = {
				preview = {
					filesize_limit = 0.25, -- in MB
					timeout = 250, -- in ms
				},
			},
		},
	},

	-- Grug Far (Global Find-and-Replace) setup
	-- No cmd/event needed for lazy loading, since grug-far defers its own requires internally
	{ "MagicDuck/grug-far.nvim", opts = {} },

	-- Gitsigns setup
	{
		"lewis6991/gitsigns.nvim",
		version = "^2.1.0",
		event = "VeryLazy",
		config = true,
	},

	-- Blame (Git Blame) setup
	{
		"FabijanZulj/blame.nvim",
		cmd = "BlameToggle",
		opts = { date_format = "%Y.%m.%d" },
	},

	-- Autopairs setup
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	-- Surround setup
	{
		"kylechui/nvim-surround",
		version = "^2.1.1",
		event = "VeryLazy",
		config = true,
	},

	-- Auto-save setup
	{
		"okuuva/auto-save.nvim",
		event = { "InsertLeave", "TextChanged" },
		config = true,
	},

	-- Sort setup
	{
		"sQVe/sort.nvim",
		cmd = "Sort",
		config = true,
	},

	-- Snacks setup
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
		},
	},

	-- Conform (Auto-Formatter) setup
	{
		"stevearc/conform.nvim",
		version = "^5.4.0",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>F",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Run auto-formatter",
			},
		},
		opts = {
			formatters_by_ft = {
				css = { "prettier" },
				html = { "prettier" },
				htmldjango = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				json = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				python = { "ruff_format" },
				rust = { "rustfmt" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
			},
		},
	},

	-- Which-key (Key Map Helper) setup
	{
		"folke/which-key.nvim",
		version = "^3.17.0",
		opts = {
			preset = "helix",
			plugins = {
				marks = false,
				registers = false,
			},
			show_help = false,
		},
	},

	-- Treesitter setup
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter").install({
				"bash",
				"css",
				"dockerfile",
				"gitcommit",
				"go",
				"html",
				"javascript",
				"json",
				"just",
				"lua",
				"make",
				"markdown",
				"markdown_inline",
				"python",
				"ruby",
				"rust",
				"toml",
				"typescript",
				"yaml",
			})
			-- Enable treesitter highlighting and indentation on any buffer with an installed parser
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("nwj_treesitter", {}),
				callback = function(args)
					if pcall(vim.treesitter.start, args.buf) then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},

	-- Blink.cmp (Completion Engine) setup
	{
		"saghen/blink.cmp",
		version = "^1.10.2",
		opts = {
			keymap = { preset = "super-tab" },
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
				},
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		ft = {
			"css",
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"lua",
			"markdown",
			"python",
			"rust",
			"typescript",
			"typescriptreact",
		},
		config = function()
			vim.lsp.config("lua_ls", {
				-- These settings mostly only make sense if you're using lua primarily in the context of configuring Neovim
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						workspace = {
							CheckThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					},
				},
			})
			vim.lsp.enable({
				"cssls",
				"html",
				"jsonls",
				"lua_ls",
				"marksman",
				"basedpyright",
				"rust_analyzer",
				"ts_ls",
			})
		end,
	},
})

-- Key Mappings
local wk = require("which-key")
local map = vim.keymap.set

wk.add({
	{ "<leader>*", "<cmd>Telescope grep_string<cr>", desc = "Grep word under the cursor" },
	{ "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Open grep picker" },
	{ "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Open buffer picker" },
	{ "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Open file picker" },
	{ "<leader>a", group = "Cursor actions" },
	{ "<leader>a*", "<cmd>Telescope grep_string<cr>", desc = "Grep word under the cursor" },
	{ "<leader>aR", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename word under the cursor" },
	{ "<leader>ad", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto definition of word under the cursor" },
	{ "<leader>ah", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview git hunk at the cursor" },
	{ "<leader>ai", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Show info about word under the cursor" },
	{ "<leader>ar", "<cmd>Telescope lsp_references<cr>", desc = "Find references to word under the cursor" },
	{ "<leader>at", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto type definition of word under the cursor" },
	{ "<leader>p", group = "Pickers" },
	{ "<leader>p/", "<cmd>Telescope live_grep<cr>", desc = "Open grep picker" },
	{ "<leader>pS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Open workspace symbol picker" },
	{ "<leader>pb", "<cmd>Telescope buffers<cr>", desc = "Open buffer picker" },
	{ "<leader>pd", "<cmd>Telescope diagnostics<cr>", desc = "Open diagnostic picker" },
	{ "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Open file picker" },
	{ "<leader>pm", "<cmd>Telescope marks<cr>", desc = "Open mark picker" },
	{ "<leader>pr", "<cmd>Telescope registers<cr>", desc = "Open register picker" },
	{ "<leader>ps", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Open symbol picker" },
	{ "<leader>pc", "<cmd>Telescope colorscheme<cr>", desc = "Open colorscheme picker" },
	{ "<leader>t", group = "Toggle settings" },
	{ "<leader>th", "<cmd>set hlsearch!<cr>", desc = "Toggle search highlighting" },
	{ "<leader>tn", "<cmd>set number!<cr>", desc = "Toggle line numbers" },
	{ "<leader>tr", "<cmd>set relativenumber!<cr>", desc = "Toggle relative line numbers" },
	{ "<leader>ts", "<cmd>set spell!<cr>", desc = "Toggle spell check" },
	{ "<leader>tw", "<cmd>set wrap!<cr>", desc = "Toggle line wrapping" },
	{ "<leader>tb", "<cmd>BlameToggle<cr>", desc = "Toggle git blame view" },
	{
		"<leader>ti",
		"<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>",
		desc = "Toggle inlay hints",
	},
})

-- Unbind Q since exmode is just annoying
map("n", "Q", "<NOP>")

-- More intuitive movement on lines that wrap
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Maintain visual selection when indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Keep the cursor in place while joining lines
map("n", "J", "mzJ`z")

-- Move lines up or down
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Easier buffer movement
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Jump between git hunks. In vimdiff-style windows (:h diff-mode), where there are no
-- hunks, fall back to the builtin ]c/[c motions that jump between changes instead.
map("n", "]h", function()
	if vim.wo.diff then
		vim.cmd.normal({ "]c", bang = true })
	else
		require("gitsigns").nav_hunk("next")
	end
end, { desc = "Next git hunk" })
map("n", "[h", function()
	if vim.wo.diff then
		vim.cmd.normal({ "[c", bang = true })
	else
		require("gitsigns").nav_hunk("prev")
	end
end, { desc = "Prev git hunk" })

-- Use Snack's bufdelete instead of built-in buffer delete
vim.cmd([[cnoreabbrev bd lua require('snacks').bufdelete()]])

-- Get write permission when you forget sudo
map("c", "w!!", "w !sudo tee %")

-- Expand file location of current buffer
map("c", "%%", "<C-R>=expand('%:h').'/'<cr>")

-- Autocommands and Filetype-specific setup

-- Markdown: turn on spell check and enable nicer line wrapping
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	group = vim.api.nvim_create_augroup("nwj_markdown", {}),
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
	end,
})
