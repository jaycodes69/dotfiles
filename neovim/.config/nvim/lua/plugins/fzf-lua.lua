return {
	"ibhagwan/fzf-lua",
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		local fzf = require("fzf-lua")

		keymap = {
			-- Use j/k in fzf window after <Esc> to navigate
			fzf = {
				["esc"] = "toggle-mode", -- insert ↔ normal
				["ctrl-j"] = "down",
				["ctrl-k"] = "up",
			},
		}

		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		map("n", "<leader>ff", fzf.files, { desc = "🔍 Find Files" })
		map("n", "<leader>fg", fzf.live_grep, { desc = "🔎 Live Grep" })
		map("n", "<leader>fh", fzf.helptags, { desc = "Find Help" })
		map("n", "<leader>fo", fzf.oldfiles, { desc = "Oldfiles" })
		map("n", "<leader>fk", fzf.keymaps, { desc = "Keymaps" })
		map("n", "<leader><leader>", function()
			fzf.files({ cwd = "~/notes", prompt = "📝 Notes❯ " })
		end, { desc = "📝 Notes" })

		map("n", "<leader>fd", function()
			fzf.files({ cwd = "~/dotfiles", prompt = "⚙️ Dotfiles❯ " })
		end, { desc = "⚙️ Dotfiles" })

		map("n", "<leader>fn", function()
			fzf.files({ cwd = vim.fn.stdpath("config"), prompt = " Config❯ " })
		end, { desc = " Neovim Config" })

		map("n", "<leader>fr", fzf.resume, { desc = "⏪ Resume Last Search" })
	end,
}
