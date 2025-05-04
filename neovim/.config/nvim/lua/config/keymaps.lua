vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open Parent Directory in OIL" })

vim.keymap.set("n", "<leader>,", "<cmd>write<CR>", { desc = "[ , ] Write the File" })
vim.keymap.set("n", "<leader>q", "<cmd>quit!<CR>", { desc = "[Q]uit the File" })

vim.keymap.set("n", "gl", function()
	vim.diagnostic.open_float()
end, { desc = "Open Diagnostic in Float" })

vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({
		lsp_format = "fallback",
	})
end, { desc = "Current buffer Format" })

-- Neorg keymaps
vim.keymap.set("n", "<leader>nl", "<Plug>(neorg.esupports.hop.hop-link)", { desc = "Neorg: Follow Link" })
vim.keymap.set("n", "<leader>nt", "<cmd>Neorg toc<CR>", { desc = "Neorg: Table of Contents" })
vim.keymap.set("n", "<leader>ni", "<cmd>Neorg index<CR>", { desc = "Neorg: Go to index" })
vim.keymap.set("n", "<leader>nr", "<cmd>Neorg return<CR>", { desc = "Neorg: Return" })
vim.keymap.set("n", "<leader>nj", "<cmd>Neorg journal<CR>", { desc = "Neorg: Journal" })

--Toggle keymaps

vim.keymap.set("n", "<leader>tg", function()
	local wo = vim.wo

	local toggle_state = not wo.number

	-- Toggle number-related UI
	wo.number = toggle_state
	wo.relativenumber = toggle_state
	wo.signcolumn = toggle_state and "yes" or "no"

	-- Opposite toggle for wrap
	wo.wrap = not toggle_state
end, { desc = "Toggle line numbers, wrap (inverted), and gutter" })

-- Navigation keymaps
-- Fast Scrolling (horizontal + vertical)
vim.keymap.set("n", "<C-h>", "10zh", { noremap = true, silent = true, desc = "Scroll Left (10 cols)" })
vim.keymap.set("n", "<C-l>", "10zl", { noremap = true, silent = true, desc = "Scroll Right (10 cols)" })
vim.keymap.set("n", "<C-j>", "10<C-e>", { noremap = true, silent = true, desc = "Scroll Down (10 lines)" })
vim.keymap.set("n", "<C-k>", "10<C-y>", { noremap = true, silent = true, desc = "Scroll Up (10 lines)" })
