return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = vim.fn.executable("make") == 1,
		},
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local themes = require("telescope.themes")

		telescope.setup({
			defaults = {
				prompt_prefix = "🔍 ",
				selection_caret = " ",
				entry_prefix = "  ",
				sorting_strategy = "ascending",
				scroll_strategy = "cycle",
				layout_strategy = "flex", -- switches between horizontal/vertical intelligently
				layout_config = {
					prompt_position = "top",
					horizontal = {
						preview_width = 0.6,
					},
					vertical = {
						mirror = true,
					},
					width = 0.95,
					height = 0.85,
				},
				winblend = 10, -- transparency
				preview = {
					hide_on_startup = false,
				},
				border = true,
				borderchars = {
					prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
					results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
					preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				},
				path_display = { "smart" },
				color_devicons = true,
			},

			pickers = {
				find_files = themes.get_dropdown({
					previewer = true,
					winblend = 100,
				}),

				live_grep = themes.get_ivy({
					winblend = 100,
					previewer = true,
					layout_config = {
						height = 0.4,
					},
				}),

				oldfiles = themes.get_dropdown({
					previewer = true,
					winblend = 100,
				}),

				help_tags = themes.get_dropdown({
					previewer = true,
					winblend = 100,
				}),

				keymaps = themes.get_dropdown({
					previewer = false,
					winblend = 150,
				}),
			},

			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		pcall(telescope.load_extension, "fzf")

		local map = vim.keymap.set
		map("n", "<leader>ff", builtin.find_files, { desc = "🔍 Find Files" })
		map("n", "<leader>fg", builtin.live_grep, { desc = "🔎 Live Grep" })
		map("n", "<leader>fh", builtin.help_tags, { desc = "📚 Help Tags" })
		map("n", "<leader>fo", builtin.oldfiles, { desc = "📂 Old Files" })
		map("n", "<leader>fk", builtin.keymaps, { desc = "⌨️ Keymaps" })
		map("n", "<leader>fr", builtin.resume, { desc = "⏪ Resume Last Search" })

		map("n", "<leader>fj", function()
			builtin.ivy({
				prompt_title = "📝 Notes",
				cwd = "~/LIFE",
				previewer = true,
				hidden = true,
				theme = "ivy",
				winblend = 15,
			})
		end, { desc = "📝 Notes" })

		map("n", "<leader>fd", function()
			builtin.find_files({
				prompt_title = "⚙️ Dotfiles",
				cwd = "~/dotfiles",
				hidden = true,
				previewer = true,
				theme = "ivy",
				winblend = 20,
			})
		end, { desc = "⚙️ Dotfiles" })

		map("n", "<leader>fn", function()
			builtin.find_files({
				prompt_title = " Neovim Config",
				cwd = vim.fn.stdpath("config"),
				previewer = true,
				theme = "ivy",
				winblend = 15,
			})
		end, { desc = " Neovim Config" })
	end,
}
