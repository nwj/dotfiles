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
vim.opt.foldmethod = "syntax"
vim.opt.foldenable = false

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

	-- Lualine (Status Bar) setup
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		priority = 1000,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = true,
	},

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

	-- Formatter setup
	{
		"mhartington/formatter.nvim",
		cmd = { "Format", "FormatWrite" },
		config = function()
			require("formatter").setup({
				filetype = {
					css = { require("formatter.filetypes.css").prettier },
					go = { require("formatter.filetypes.go").gofmt },
					html = { require("formatter.filetypes.html").prettier },
					javascript = { require("formatter.filetypes.javascript").prettier },
					json = { require("formatter.filetypes.json").prettier },
					lua = { require("formatter.filetypes.lua").stylua },
					markdown = { require("formatter.filetypes.markdown").prettier },
					ruby = { require("formatter.filetypes.ruby").rubocop },
					rust = { require("formatter.filetypes.rust").rustfmt },
					typescript = { require("formatter.filetypes.typescript").prettier },
					typescriptreact = { require("formatter.filetypes.typescriptreact").prettier },
				},
			})
		end,
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

	-- Treesitter setup
	{
		"nvim-treesitter/nvim-treesitter",
		version = "^0.9.1",
		build = ":TSUpdate",
		event = "VeryLazy",
		opts = {
			ensure_installed = {
				"bash",
				"css",
				"csv",
				"dockerfile",
				"gitcommit",
				"go",
				"html",
				"javascript",
				"json",
				"lua",
				"make",
				"python",
				"ruby",
				"rust",
				"toml",
				"tsv",
				"typescript",
				"yaml",
			},
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		},
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
wk.register({
	["<leader>f"] = { "<cmd>Telescope find_files<cr>", "Open file picker" },
	["<leader>b"] = { "<cmd>Telescope buffers<cr>", "Open buffer picker" },
	["<leader>/"] = { "<cmd>Telescope live_grep<cr>", "Open grep picker" },
	["<leader>*"] = { "<cmd>Telescope grep_string<cr>", "Grep word under the cursor" },
	["<leader>s"] = { "<cmd>Telescope lsp_document_symbols<cr>", "Open symbol picker" },
	["<leader>S"] = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Open workspace symbol picker" },
	["<leader>m"] = { "<cmd>Telescope marks<cr>", "Open mark picker" },
	['<leader>"'] = { "<cmd>Telescope registers<cr>", "Open register picker" },
	["<leader>d"] = { "<cmd>Telescope lsp_definitions<cr>", "Goto definition of word under the cursor" },
	["<leader>y"] = { "<cmd>Telescope lsp_type_definitions<cr>", "Goto type definition of word under the cursor" },
	["<leader>r"] = { "<cmd>Telescope lsp_references<cr>", "Find references to word under the cursor" },
	["<leader>R"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename word under the cursor (in current buffer only)" },
	["<leader>p"] = { "<cmd>set spell!<cr>", "Toggle spellcheck" },
	["<leader>h"] = { "<cmd>set hlsearch!<cr>", "Toggle search highlighting" },
	["<leader>F"] = { "<cmd>Format<cr>", "Run auto-formatter" },
	["<leader>i"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show info about word under the cursor" },
})

local map = function(keymap)
	local opts = { noremap = true }
	for k, v in pairs(keymap) do
		if type(k) == "string" then
			opts[k] = v
		end
	end
	vim.api.nvim_set_keymap(keymap[1], keymap[2], keymap[3], opts)
end

-- Unbind Q since exmode is just annoying
map({ "n", "Q", "<NOP>" })

-- Make Y behave more like D, C, etc. (default behavior is effectively yy)
map({ "n", "Y", "y$" })

-- More intuitive movement on lines that wrap
map({ "n", "j", "gj" })
map({ "n", "k", "gk" })
map({ "v", "j", "gj" })
map({ "v", "k", "gk" })

-- Keep the cursor in place while joining lines
map({ "n", "J", "mzJ`z" })

-- Get write permission when you forget sudo
map({ "c", "w!!", "w !sudo tee %" })

-- Expand file location of current buffer
map({ "c", "%%", "<C-R>=expand('%:h').'/'<cr>" })

-- Autocommands and Filetype-specific setup

-- Markdown
vim.g.vim_markdown_frontmatter = 1 -- Highlight markdown yaml frontmatter properly
vim.g.vim_markdown_new_list_item_indent = 0 -- Slightly better new line indentation on lists
vim.cmd("autocmd BufNewFile,BufRead *.md setlocal spell") -- Turn spell check on for markdown files
vim.cmd("autocmd BufNewFile,BufRead *.md setlocal wrap") -- Enable line wrapping for markdown files
vim.cmd("autocmd BufNewFile,BufRead *.md setlocal linebreak")
