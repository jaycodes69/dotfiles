return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		-- Kill top tabline (prevent bufferline or default tabs)
		vim.opt.showtabline = 0
		vim.opt.termguicolors = true

		require("lualine").setup({
			options = {
				theme = "kanagawa",
				icons_enabled = true,
				component_separators = "", -- clean look
				section_separators = "",
				always_divide_middle = false,
				globalstatus = true,
				disabled_filetypes = { "NvimTree", "neo-tree", "lazy", "alpha" },
			},

			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return str:sub(1, 1)
						end, -- Just N, I, etc.
						icon = "",
					},
				},
				lualine_b = {
					{
						"branch",
						icon = "",
						fmt = function(str)
							return str == "" and "no-vcs" or str
						end,
					},
				},
				lualine_c = {
					{
						"filename",
						path = 1, -- relative path
						symbols = {
							modified = " ●",
							readonly = " 🔒",
							unnamed = "[No Name]",
						},
					},
				},
				lualine_x = {
					{
						"diagnostics",
						sources = { "nvim_lsp" },
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = "󰌵 ",
						},
						update_in_insert = false,
					},
				},
				lualine_y = {
					{ "filetype", icon_only = true, padding = { left = 0, right = 1 } },
				},
				lualine_z = {
					{ "location", padding = 0 },
				},
			},

			inactive_sections = {
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "location" },
			},

			tabline = {
				lualine_a = {
					{
						"buffers",
						show_filename_only = true,
						mode = 2,
						symbols = {
							modified = " ●",
							alternate_file = "",
							directory = " ",
						},
						filetype_names = {
							TelescopePrompt = "Telescope",
							alpha = "Start",
						},
						buffers_color = {
							active = "lualine_a_normal",
							inactive = "lualine_c_inactive",
						},
						use_mode_colors = false,
					},
				},
				lualine_z = {
					{
						"tabs",
						mode = 1,
						max_length = vim.o.columns * 2 / 3,
						tabs_color = {
							active = "lualine_a_normal",
							inactive = "lualine_b_inactive",
						},
					},
				},
			},

			extensions = { "fugitive", "quickfix", "man", "lazy" },
		})
	end,
}
