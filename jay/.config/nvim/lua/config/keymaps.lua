local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set leader key
vim.g.mapleader = " "

-- ╭─────────────────────────────────────╮
-- │ Mini.files (file explorer)          │
-- ╰─────────────────────────────────────╯
map("n", "<leader>e", function()
	require("mini.files").open(vim.api.nvim_buf_get_name(0))
end, { desc = "MiniFiles (current dir)" })

map("n", "<leader>E", function()
	require("mini.files").open(nil, true)
end, { desc = "MiniFiles (root dir)" })

-- ╭─────────────────────────────────────╮
-- │ Window & Buffer Navigation          │
-- ╰─────────────────────────────────────╯
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "<S-h>", ":bprev<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })

map("n", "<leader>bd", ":bdelete<CR>", { desc = "Close buffer" })

-- ╭─────────────────────────────────────╮
-- │ Telescope                          │
-- ╰─────────────────────────────────────╯
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Grep files" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffer" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })

-- ╭─────────────────────────────────────╮
-- │ Quality of Life                    │
-- ╰─────────────────────────────────────╯
map("n", "<leader>qq", "<cmd>q!<CR>", { desc = "Quit" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })

-- Clear search highlight
map("n", "<Esc>", ":noh<CR>", { desc = "Clear search highlight" })

-- ╭─────────────────────────────────────╮
-- │ Diagnostics / LSP                  │
-- ╰─────────────────────────────────────╯
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- ╭─────────────────────────────────────╮
-- │ Visual Mode: Move lines up/down    │
-- ╰─────────────────────────────────────╯
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
