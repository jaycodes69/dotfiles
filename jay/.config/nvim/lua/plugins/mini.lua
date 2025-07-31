return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		local mini = {
			basics = require("mini.basics"),
			pairs = require("mini.pairs"),
			statusline = require("mini.statusline"),
			indent = require("mini.indentscope"),
			icons = require("mini.icons"),
			files = require("mini.files"),
			ai = require("mini.ai"),
			surround = require("mini.surround"),
		}

		-- Basic enhancements: mappings, options, autocommands
		mini.basics.setup({})

		-- Auto-pairing of brackets, quotes, etc.
		mini.pairs.setup({})

		-- Simple, clean statusline with icons
		mini.statusline.setup({
			use_icons = true,
		})

		-- Show indent guides
		mini.indent.setup({})

		-- Add devicons for LSP, UI, etc.
		mini.icons.setup({})

		-- File Explorer: mini.files
		mini.files.setup({
			windows = {
				preview = false, -- Enable file preview
				width_focus = 35,
				width_nofocus = 25,
			},
			mappings = {
				go_in_plus = "<CR>", -- default enter to open/expand
				go_out = "H", -- move to parent directory
				synchronize = "<leader>fS", -- custom key to sync FS
			},
			options = {
				use_as_default_explorer = true,
				hide_dotfiles = false,
			},
		})

		-- Better text objects: `vai`, `vi"`, `va)` etc.
		mini.ai.setup({
			n_lines = 500,
		})

		-- Surround text: `gsa`, `gsr`, `gsd`
		mini.surround.setup({})
	end,
}
