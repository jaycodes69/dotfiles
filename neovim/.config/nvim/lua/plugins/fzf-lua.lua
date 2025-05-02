return {
	"ibhagwan/fzf-lua",
	dependencies = { "echasnovski/mini.icons" },
	opts = {
		previewers = {
			builtin = { syntax_highlight = true },
			bat = {
				theme = "Dracula",
				args = "--style=numbers,changes --color=always",
			},
		},
		files = {
			previewer = "bat",
			fd_opts = "--color=never --type f --hidden --follow --exclude .git",
		},
		grep = { previewer = "bat" },
	},
	keys = {
		{ "<leader>ff", "<cmd>FzfLua files<CR>", desc = "󰍉 Find Files" },
		{ "<leader>fg", "<cmd>FzfLua live_grep<CR>", desc = "󰱽 Live Grep in Project" },
		{
			"<leader>fn",
			"<cmd>FzfLua files cwd=" .. vim.fn.stdpath("config") .. "<CR>",
			desc = " Find Neovim Config Files",
		},
		{ "<leader><leader>", "<cmd>FzfLua buffers<CR>", desc = " Open Buffers" },
		{ "<leader>fh", "<cmd>FzfLua helptags<CR>", desc = "󰋖 Help Tags" },
		{ "<leader>fk", "<cmd>FzfLua keymaps<CR>", desc = "󰌌 Keymaps" },
		{ "<leader>fb", "<cmd>FzfLua builtin<CR>", desc = " FZF Builtins" },
		{ "<leader>fw", "<cmd>FzfLua grep_cword<CR>", desc = " Grep word under cursor" },
		{ "<leader>fW", "<cmd>FzfLua grep_cWORD<CR>", desc = " Grep WORD under cursor" },
		{ "<leader>fd", "<cmd>FzfLua diagnostics_document<CR>", desc = " Document Diagnostics" },
		{ "<leader>fr", "<cmd>FzfLua resume<CR>", desc = "󰑍 Resume last search" },
		{ "<leader>fo", "<cmd>FzfLua oldfiles<CR>", desc = "󰄉 Recently Opened Files" },
		{ "<leader>f/", "<cmd>FzfLua grep_curbuf<CR>", desc = "󰅺 Grep in Current Buffer" },
	},
}
