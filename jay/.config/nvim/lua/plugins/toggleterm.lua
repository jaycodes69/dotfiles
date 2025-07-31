return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			direction = "float",
			float_opts = {
				border = "curved",
				winblend = 3,
			},
			shade_terminals = true,
			start_in_insert = true,
			persist_mode = false,
		})

		local Terminal = require("toggleterm.terminal").Terminal

		-- C++ Runner
		function _G.run_cpp_file()
			local file = vim.fn.expand("%:p") -- full path
			local filename = vim.fn.expand("%:t:r") -- file name without extension
			local bin_dir = vim.fn.getcwd() .. "/.bin"
			local bin_file = bin_dir .. "/" .. filename

			-- Create .bin directory if it doesn't exist
			if vim.fn.isdirectory(bin_dir) == 0 then
				vim.fn.mkdir(bin_dir, "p")
			end

			-- Save file first
			vim.cmd("w")

			-- Compilation command
			local compile_cmd = string.format('g++ -std=c++17 -O2 -Wall "%s" -o "%s" && "%s"', file, bin_file, bin_file)

			-- Float terminal
			local cpp_term = Terminal:new({
				cmd = compile_cmd,
				direction = "float",
				close_on_exit = false,
				hidden = true,
			})

			cpp_term:toggle()
		end

		-- Keymap <leader>rr
		vim.keymap.set(
			"n",
			"<leader>rr",
			"<cmd>lua run_cpp_file()<CR>",
			{ desc = "Run C++ file", noremap = true, silent = true }
		)
	end,
	keys = {
		{ "<leader>rr", desc = "Run current C++ file" },
	},
}
