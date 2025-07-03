-- Keymaps for fast, mouseless workflow
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " " -- Space as leader

-- === General ===
map("n", "<Esc>", ":noh<CR>", vim.tbl_extend("force", opts, { desc = "Clear search highlights" }))
map("n", "<leader>w", ":w<CR>", vim.tbl_extend("force", opts, { desc = "Save file" }))
map("n", "<leader>q", ":q<CR>", vim.tbl_extend("force", opts, { desc = "Quit file" }))
map("n", "<leader>Q", ":qa!<CR>", vim.tbl_extend("force", opts, { desc = "Force quit all" }))

-- === Windows ===
map("n", "<C-h>", "<C-w>h", vim.tbl_extend("force", opts, { desc = "Move left" }))
map("n", "<C-j>", "<C-w>j", vim.tbl_extend("force", opts, { desc = "Move down" }))
map("n", "<C-k>", "<C-w>k", vim.tbl_extend("force", opts, { desc = "Move up" }))
map("n", "<C-l>", "<C-w>l", vim.tbl_extend("force", opts, { desc = "Move right" }))

map("n", "<C-Up>", ":resize +2<CR>", vim.tbl_extend("force", opts, { desc = "Resize window taller" }))
map("n", "<C-Down>", ":resize -2<CR>", vim.tbl_extend("force", opts, { desc = "Resize window shorter" }))
map("n", "<C-Left>", ":vertical resize -2<CR>", vim.tbl_extend("force", opts, { desc = "Resize window narrower" }))
map("n", "<C-Right>", ":vertical resize +2<CR>", vim.tbl_extend("force", opts, { desc = "Resize window wider" }))

-- === Buffers ===
map("n", "<Tab>", ":bnext<CR>", vim.tbl_extend("force", opts, { desc = "Next buffer" }))
map("n", "<S-Tab>", ":bprev<CR>", vim.tbl_extend("force", opts, { desc = "Previous buffer" }))
map("n", "<leader>dd", ":bdelete<CR>", vim.tbl_extend("force", opts, { desc = "Delete buffer" }))

-- === Diagnostics ===
map("n", "<leader>ll", function()
	vim.diagnostic.open_float()
end, vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))

-- === File Management ===
map("n", "-", "<CMD>Oil --float<CR>", vim.tbl_extend("force", opts, { desc = "Open Oil file manager" }))

-- === Rename Current File ===
map("n", "<leader>rn", function()
	local old = vim.fn.expand("%")
	local new = vim.fn.input("Rename to: ", old)
	if new ~= "" and new ~= old then
		vim.cmd("saveas " .. new)
		vim.fn.delete(old)
		vim.cmd("bdelete " .. old)
		vim.notify("Renamed " .. old .. " → " .. new, vim.log.levels.INFO)
	end
end, vim.tbl_extend("force", opts, { desc = "Rename current file" }))

-- === Reload Neovim Config ===
map("n", "<leader><leader>", function()
	for name, _ in pairs(package.loaded) do
		if name:match("^jay") or name:match("^plugins") or name:match("^core") then
			package.loaded[name] = nil
		end
	end

	dofile(vim.fn.stdpath("config") .. "/init.lua")
	vim.cmd("LspRestart")
	vim.notify("Neovim reloaded!", vim.log.levels.INFO)
end, vim.tbl_extend("force", opts, { desc = "Reload Neovim config" }))
