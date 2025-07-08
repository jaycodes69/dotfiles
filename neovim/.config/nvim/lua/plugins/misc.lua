return {
	-- 🧠 Auto pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	-- 🧠 Indentation detection
	{
		"NMAC427/guess-indent.nvim",
		event = "BufReadPre",
		opts = {},
	},

	-- 🔔 LSP progress UI
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		opts = {
			progress = {
				display = {
					done_ttl = 3,
					progress_icon = { "dots" },
				},
			},
			notification = {
				window = {
					winblend = 0,
				},
			},
		},
	},

	-- 🧠 Lua dev tools for Neovim
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				"lazy.nvim",
				"nvim-treesitter",
				"fzf-lua",
				"kanagawa.nvim",
				"nvim-lspconfig",
				"mason.nvim",
				"which-key.nvim",
				"lazydev.nvim",
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
			enabled = function(root_dir)
				return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
			end,
			integrations = {
				lspconfig = true,
				cmp = false,
				coq = false,
			},
		},
	},

	-- 🚀 ToggleTerm with C++ integration
	{
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm", "RunCpp" },
		keys = { { "<leader>rr", "<cmd>RunCpp<CR>", desc = "Run current C++ file" } },
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<C-\>]],
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = 2,
				direction = "float",
				float_opts = {
					border = "curved",
				},
			})

			vim.api.nvim_create_user_command("RunCpp", function()
				local filepath = vim.api.nvim_buf_get_name(0)
				if not filepath:match("%.cpp$") then
					vim.notify("Not a C++ file", vim.log.levels.ERROR)
					return
				end

				vim.cmd("write")
				local dir = vim.fn.fnamemodify(filepath, ":h")
				local filename = vim.fn.fnamemodify(filepath, ":t:r")
				local bin_dir = dir .. "/.bin"
				local output = bin_dir .. "/" .. filename
				vim.fn.mkdir(bin_dir, "p")

				local cmd = string.format("g++ -std=c++20 -O2 -Wall '%s' -o '%s' && '%s'", filepath, output, output)
				local Terminal = require("toggleterm.terminal").Terminal
				local cpp_term = Terminal:new({
					cmd = cmd,
					dir = dir,
					direction = "float",
					close_on_exit = false,
					hidden = true,
				})
				cpp_term:toggle()
			end, { desc = "Compile and Run C++ file" })
		end,
	},

	-- 📏 Indent guides
	{
		"lukas-reineke/indent-blankline.nvim",
		ft = { "cpp" },
		main = "ibl",
		opts = {},
	},
	{
		"folke/zen-mode.nvim",
		lazy = true,
		cmd = "ZenMode",
		dependencies = {
			"folke/twilight.nvim", -- dims inactive code
		},
		opts = {
			-- How big the Zen window should be
			window = {
				backdrop = 0.90, -- Darken the backdrop a bit more
				width = 0.5,
				height = 1.0, -- Always full height
				options = {
					number = false,
					relativenumber = false,
					wrap = true,
					signcolumn = "no",
					foldcolumn = "0",
					list = false,
					cursorline = false,
					cursorcolumn = false,
				},
			},

			-- Plugins to enable/disable when ZenMode opens
			plugins = {
				options = {
					enabled = true, -- apply global Vim options
					ruler = false,
					showcmd = false,
					laststatus = 0, -- hide statusline
					cmdheight = 1, -- shrink cmd height
				},
				twilight = { enabled = true }, -- require("twilight").setup() elsewhere
				gitsigns = { enabled = false }, -- hide git signs
				tmux = { enabled = false }, -- hide tmux statusbar
				nvimtree = { enabled = false }, -- hide NvimTree sidebar
				barbecue = { enabled = false }, -- hide nav breadcrumbs
				todo = { enabled = true }, -- keep TODO highlights
				kitty = { enabled = false },
				alacritty = { enabled = false },
				wezterm = { enabled = false },
				neovide = {
					enabled = true,
					scale = 1.15,
					disable_animations = {
						neovide_animation_length = 0,
						neovide_scroll_animation_length = 0,
						neovide_cursor_animation_length = 0,
						neovide_position_animation_length = 0,
						neovide_cursor_vfx_mode = "",
					},
				},
			},

			-- Called when entering Zen
			on_open = function(win)
				-- Center the view
				vim.cmd("set scrolloff=0")
				-- Make sure wrap + linebreaks for prose
				vim.opt.wrap = true
				vim.opt.linebreak = true
				-- Enable spell for writing
				vim.opt.spell = true
				-- Optionally disable LSP diagnostics popup
				vim.diagnostic.enable(false)
			end,

			-- Called when leaving Zen
			on_close = function()
				-- Restore defaults
				vim.cmd("set scrolloff=8")
				vim.opt.wrap = false
				vim.opt.linebreak = false
				vim.opt.spell = false
				-- Re-enable diagnostics
				vim.diagnostic.enable()
			end,
		},
		keys = {
			{
				"<leader>zz",
				function()
					require("zen-mode").toggle()
				end,
				desc = "Toggle Zen Mode",
			},
		},
	},
}
