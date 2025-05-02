-- lua/plugins/which-key.lua
return {
	"folke/which-key.nvim", -- popup for keybinding help
	event = "VeryLazy", -- lazy-load
	init = function() -- required vim settings
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {}, -- use all default behavior
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "WhichKey: buffer mappings",
		},
	},
}
