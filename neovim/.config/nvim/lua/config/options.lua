-- options.lua
local opt = vim.opt

-- 🔤 Encoding & Clipboard
opt.encoding = "utf-8"
opt.clipboard = "unnamedplus"
opt.foldlevel = 999
opt.mouse = "a"

-- 📁 File handling
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("cache") .. "/undo"

-- 🖥 UI
opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.cmdheight = 1
opt.laststatus = 3
opt.conceallevel = 2
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

-- 📏 Tabs & Indentation
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 0 -- use tabstop value (recommended) :contentReference[oaicite:1]{index=1}
opt.smartindent = true

-- 🔍 Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

-- 🔧 Splits
opt.splitright = true
opt.splitbelow = true

-- ⚡ Performance
opt.updatetime = 200
opt.timeoutlen = 400
opt.belloff = "all" -- disable system bells
opt.shortmess:append("c") -- clean completion messages :contentReference[oaicite:3]{index=3}

-- 📦 Better wildignore
opt.wildignore = { "*.o", "*.obj", "*.pyc", "*/node_modules/*", "*/.git/*" }

-- 🧠 Formatoptions control
opt.formatoptions:remove({ "c", "r", "o" }) -- avoid auto comment continuation

-- Neovide Settings
if vim.g.neovide then
	opt.guifont = "JetBrainsMono Nerd Font:h14"
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_refresh_rate_idle = 5
	vim.g.neovide_fullscreen = true
	vim.g.neovide_no_idle = false
	vim.g.neovide_opacity = 0.8
	opt.mouse = "c"
	vim.keymap.set("v", "<D-c>", '"+y')
	vim.keymap.set("n", "<D-v>", '"+P')
	vim.keymap.set("i", "<D-v>", "<C-r>+")
end

-- Yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- Markdown & Note-taking auto settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "tex" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
		vim.opt_local.conceallevel = 2
	end,
})
