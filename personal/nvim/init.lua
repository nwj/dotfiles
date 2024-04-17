-------------------------------------------------------------------------------------------------------------
-- NEOVIM CONFIGURATION | Author: nwj
-------------------------------------------------------------------------------------------------------------

-- Set leader key
vim.g.mapleader = " "

-- Basic settings
vim.opt.clipboard = "unnamedplus" -- Default to use of the system clipboard
vim.opt.number = true -- Enable line numbering
vim.opt.signcolumn = "yes" -- Always show the signs gutter
vim.opt.scrolloff = 5 -- Start scrolling before reaching screen edge
vim.opt.showmatch = true -- Highlight matching parentheses and brackets
vim.opt.wrap = false -- Don't wrap long lines
vim.opt.timeout = false -- Timeout on key codes but not mappings

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

-- Represent various 'invisible' whitespace characters with symbols
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", extends = "❯", precedes = "❮", trail = "·", nbsp = "·" }

-- Setup spell check
vim.opt.spelllang = "en_us"
vim.opt.spellfile = "~/.config/nvim/dictionary.utf-8.add" -- words are added here via `zg` and removed via `zw`

-- Fold based on language, fully expand all folds at start
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

-- Disable modeline support, since it's been a security vector in the past
vim.opt.modelines = 0
vim.opt.modeline = false

-- Conditionally enable true color support
if vim.fn.has("termguicolors") == 1 then
	vim.opt.termguicolors = true
end

-- Plugin initialization
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
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

	-- Bufferline ("Tab" Bar) setup
	{
		"akinsho/bufferline.nvim",
		version = "^4.4.0",
		lazy = false,
		dependencies = "nvim-tree/nvim-web-devicons",
		config = true,
	},

	-- Telescope (Fuzzy Picker) setup
	{
		"nvim-telescope/telescope.nvim",
		version = "^0.1.4",
		cmd = "Telescope",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
	},

	-- Gitsigns setup
	{
		"lewis6991/gitsigns.nvim",
		version = "^0.6",
		event = "VeryLazy",
		config = true,
	},

	-- Comment setup
	{
		"numToStr/Comment.nvim",
		version = "^0.8",
		event = "VeryLazy",
		config = true,
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
				go = { "gofmt" },
				html = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				json = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				ruby = { "rubocop" },
				rust = { "rustfmt" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
			},
		},
	},

	-- Which-key (Key Map Helper) setup
	{
		"folke/which-key.nvim",
		version = "^1.5.1",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			marks = false,
			registers = false,
			window = {
				border = "single",
				margin = { 0, 0, 0, 0.65 },
				padding = { 0, 0, 0, 0 },
			},
			layout = { width = { max = 100 } },
			show_help = false,
		},
	},

	-- Headlines (Markdown Header Styling) setup
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = { "markdown" },
		config = function()
			-- PERF: schedule to prevent headlines slowing down opening a file
			vim.schedule(function()
				require("headlines").setup({
					markdown = {
						codeblock_highlight = false,
						quote_highlight = false,
						dash_highlight = false,
						fat_headlines = false,
					},
				})
				require("headlines").refresh()
			end)
		end,
	},

	-- Zen Mode setup
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			window = {
				backdrop = 1,
				width = 80,
				options = {
					number = false,
					relativenumber = false,
				},
			},
		},
	},

	-- Treesitter setup
	{
		"nvim-treesitter/nvim-treesitter",
		version = "^0.9.1",
		build = ":TSUpdate",
		event = "VeryLazy",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = {
					"bash",
					"css",
					"dockerfile",
					"gitcommit",
					"go",
					"html",
					"javascript",
					"json",
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
				},
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = true,
	},

	-- Cmp (Completion Engine) setup
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
		config = function()
			local cmp = require("cmp")

			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				completion = {
					autocomplete = false,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
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
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_prev_item()
						end
					end, { "i", "s" }),
				},
			})

			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})
		end,
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
			"ruby",
			"rust",
			"typescript",
			"typescriptreact",
		},
		config = function()
			local lsp = require("lspconfig")
			lsp.tsserver.setup({})
			lsp.rust_analyzer.setup({})
			lsp.solargraph.setup({})
			lsp.marksman.setup({})
			lsp.cssls.setup({})
			lsp.html.setup({})
			lsp.jsonls.setup({})
			lsp.lua_ls.setup({
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
		end,
	},
})

-- Key Mappings
local wk = require("which-key")
local map = vim.keymap.set

wk.register({
	["<leader>*"] = { "<cmd>Telescope grep_string<cr>", "Grep word under the cursor" },
	["<leader>/"] = { "<cmd>Telescope live_grep<cr>", "Open grep picker" },
	["<leader>b"] = { "<cmd>Telescope buffers<cr>", "Open buffer picker" },
	["<leader>f"] = { "<cmd>Telescope find_files<cr>", "Open file picker" },
	["<leader>a"] = { name = "+Cursor actions" },
	["<leader>a*"] = { "<cmd>Telescope grep_string<cr>", "Grep word under the cursor" },
	["<leader>aR"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename word under the cursor (in current buffer only)" },
	["<leader>ad"] = { "<cmd>Telescope lsp_definitions<cr>", "Goto definition of word under the cursor" },
	["<leader>ai"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show info about word under the cursor" },
	["<leader>ar"] = { "<cmd>Telescope lsp_references<cr>", "Find references to word under the cursor" },
	["<leader>at"] = { "<cmd>Telescope lsp_type_definitions<cr>", "Goto type definition of word under the cursor" },
	["<leader>p"] = { name = "+Pickers" },
	["<leader>p/"] = { "<cmd>Telescope live_grep<cr>", "Open grep picker" },
	["<leader>pS"] = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Open workspace symbol picker" },
	["<leader>pb"] = { "<cmd>Telescope buffers<cr>", "Open buffer picker" },
	["<leader>pd"] = { "<cmd>Telescope diagnostics<cr>", "Open diagnostic picker" },
	["<leader>pf"] = { "<cmd>Telescope find_files<cr>", "Open file picker" },
	["<leader>pm"] = { "<cmd>Telescope marks<cr>", "Open mark picker" },
	["<leader>pr"] = { "<cmd>Telescope registers<cr>", "Open register picker" },
	["<leader>ps"] = { "<cmd>Telescope lsp_document_symbols<cr>", "Open symbol picker" },
	["<leader>pc"] = { "<cmd>Telescope colorscheme<cr>", "Open colorscheme picker" },
	["<leader>t"] = { name = "+Toggle settings" },
	["<leader>th"] = { "<cmd>set hlsearch!<cr>", "Toggle search highlighting" },
	["<leader>tn"] = { "<cmd>set number!<cr>", "Toggle line numbers" },
	["<leader>tr"] = { "<cmd>set relativenumber!<cr>", "Toggle relative line numbers" },
	["<leader>ts"] = { "<cmd>set spell!<cr>", "Toggle spell check" },
	["<leader>tw"] = { "<cmd>set wrap!<cr>", "Toggle line wrapping" },
	["<leader>tf"] = { "<cmd>ZenMode<cr>", "Toggle focus mode" },
	-- Inlay hint support isn't yet in Neovim stable, but will be soon
	-- ["<leader>ti"] = { "<cmd>lua vim.lsp.inlay_hint(0, nil)<cr>", "Toggle inlay hints" },
})

-- Unbind Q since exmode is just annoying
map("n", "Q", "<NOP>")

-- Make Y behave more like D, C, etc. (default behavior is effectively yy)
map("n", "Y", "y$")

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

-- Get write permission when you forget sudo
map("c", "w!!", "w !sudo tee %")

-- Expand file location of current buffer
map("c", "%%", "<C-R>=expand('%:h').'/'<cr>")

-- Autocommands and Filetype-specific setup

-- Markdown
vim.cmd("autocmd BufNewFile,BufRead *.md setlocal spell") -- Turn spell check on for markdown files
vim.cmd("autocmd BufNewFile,BufRead *.md setlocal wrap") -- Enable line wrapping for markdown files
vim.cmd("autocmd BufNewFile,BufRead *.md setlocal linebreak")
