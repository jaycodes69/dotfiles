return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		dependencies = {
			-- Optional: Text objects powered by Treesitter
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		opts = {
			-- 🧠 Language parsers to install
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"diff",
				"html",
				"json",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"vim",
				"vimdoc",
			},
			auto_install = true, -- Auto-install missing parsers

			-- 🌈 Syntax highlighting
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false, -- true only if needed
			},

			-- 📐 Indentation support
			indent = {
				enable = true,
				disable = { "python", "ruby" }, -- Python indentation is unreliable
			},

			-- 🧩 Incremental selection (like VSCode's expand/shrink selection)
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<leader><CR>",
					node_incremental = "<leader><CR>",
					scope_incremental = false,
					node_decremental = "<BS>",
				},
			},

			-- 🔠 Text objects (requires textobjects module)
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Jump forward to nearest text object
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- Track jump list
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>sn"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>sp"] = "@parameter.inner",
					},
				},
			},
		},
	},
}
