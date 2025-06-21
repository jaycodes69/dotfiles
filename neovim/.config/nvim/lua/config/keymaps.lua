-- Keymaps for fast, mouseless workflow
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " " -- Space as leader

-- Clear search highlight
map("n", "<Esc>", ":noh<CR>", opts)

-- Window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Fast saving and quitting
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)
map("n", "<leader>Q", ":qa!<CR>", opts)

-- Oil (file manager)
map("n", "-", "<CMD>Oil --float<CR>", opts)

map("n", "<leader>ll", function ()
    vim.diagnostic.open_float()
end, opts)

-- Quick terminal
map("n", "<leader>t", ":terminal<CR>", opts)

-- Buffer navigation
map("n", "<Tab>", ":bnext<CR>", opts)
map("n", "<S-Tab>", ":bprev<CR>", opts)
map("n", "<leader>bd", ":bdelete<CR>", opts)

