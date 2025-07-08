return {
	-- treesitter first
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "OXY2DEV/markview.nvim" },
		lazy = false,
		priority = 50, -- Markview before other color plugins
	},

	-- optional standalone config if you want to fine-tune
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		priority = 49,
		config = function()
			require("markview").setup({
				markdown = {
					headings = require("markview.presets").headings.simple,
					tables = require("markview.presets").tables.double,
				},
			})

			require("markview.extras.checkboxes").setup()
		end,
	},
}
