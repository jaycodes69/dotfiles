-- ~/.config/nvim/after/ftplugin/markdown.lua
local opt = vim.opt_local
local cmd = vim.cmd
local wk = vim.keymap.set

-- 📝 Base writing settings
opt.wrap = true
opt.linebreak = true
opt.conceallevel = 2
opt.concealcursor = "nc"
opt.textwidth = 80
opt.showmode = false

-- 📦 Format options
opt.formatoptions:append("n") -- recognize numbered lists
opt.formatoptions:remove({ "c", "r", "o" }) -- no auto-comment continuation

-- 🔧 Plugin-friendly toggles
cmd("let g:vim_markdown_folding_level = 1")
cmd("let g:vim_markdown_conceal = 1")
cmd("let g:vim_markdown_toc_autofit = 1")

-- ❌ Disable modelines—for safety in Hugo files
opt.modeline = false
