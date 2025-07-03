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
			"folke/twilight.nvim", -- dims inactive code (optional but great for focus)
		},
		opts = {
			window = {
				backdrop = 0.95,
				width = 0.8, -- 80% width of the editor
				height = 1, -- full height
				options = {
					number = false,
					relativenumber = false,
					signcolumn = "no",
					foldcolumn = "0",
					list = false,
					cursorline = false,
					cursorcolumn = false,
				},
			},
			plugins = {
				options = {
					enabled = true,
					ruler = false,
					showcmd = false,
					laststatus = 0,
				},
				twilight = { enabled = true }, -- dim inactive portions
				gitsigns = { enabled = false }, -- disable git decorations
				tmux = { enabled = false }, -- hide tmux status bar
				todo = { enabled = true }, -- keep TODO highlights
				kitty = { enabled = false },
				alacritty = { enabled = false },
				wezterm = { enabled = false },
				neovide = {
					enabled = true,
					scale = 1.2,
					disable_animations = {
						neovide_animation_length = 0,
						neovide_cursor_animate_command_line = false,
						neovide_scroll_animation_length = 0,
						neovide_position_animation_length = 0,
						neovide_cursor_animation_length = 0,
						neovide_cursor_vfx_mode = "",
					},
				},
			},
			on_open = function()
				vim.cmd("set wrap linebreak")
				vim.opt.spell = true
			end,
			on_close = function()
				vim.cmd("set nowrap nolinebreak")
				vim.opt.spell = false
			end,
		},
		keys = {
			{ "<leader>zz", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
		},
	},
}
