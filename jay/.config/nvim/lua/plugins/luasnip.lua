return {
	"L3MON4D3/LuaSnip",
	version = "v2.*", -- Use a stable release
	event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets", -- Optional: for lots of prebuilt snippets
	},
	config = function()
		require("luasnip.loaders.from_lua").lazy_load({ paths = { "~/.config/nvim/lua/snippets" } })
		require("luasnip.loaders.from_vscode").lazy_load() -- for friendly-snippets
	end,
}
