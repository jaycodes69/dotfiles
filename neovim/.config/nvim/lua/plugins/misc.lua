return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"NMAC427/guess-indent.nvim", -- Detect tabstop and shiftwidth automatically
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			progress = {
				display = {
					done_ttl = 3, -- ⏱ How long completed messages stay
					progress_icon = { "dots" }, -- ⠋ ⠙ ⠸ etc.
				},
			},
			notification = {
				window = {
					winblend = 0, -- 🧊 No transparency
				},
			},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load in Lua files
		opts = {
			-- Preload common plugin types you may reference but don't `require()`
			library = {
				"lazy.nvim", -- for Lazy.nvim APIs
				"nvim-treesitter", -- TS config
				"fzf-lua", -- for fzf-lua completions
				"kanagawa.nvim", -- theme plugin tweaks
				"nvim-lspconfig", -- useful for LSP config files
				"mason.nvim", -- mason.config APIs
				"which-key.nvim", -- if you're using mappings config
				"lazydev.nvim", -- allow LazyDev to self-describe
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } }, -- for `vim.uv` API
			},

			-- Disable LazyDev if `.luarc.json` is present (i.e. explicit config)
			enabled = function(root_dir)
				return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
			end,

			integrations = {
				lspconfig = true,
				cmp = false, -- we use `blink.cmp` instead of `nvim-cmp`
				coq = false,
			},
		},
	},
}
