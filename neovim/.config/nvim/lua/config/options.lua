-- Sensible Neovim settings
local opt = vim.opt

-- General
opt.encoding = "utf-8"
opt.mouse = ""               -- Mouse disabled: touch typist mode
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.clipboard = "unnamedplus"

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.cmdheight = 1
opt.laststatus = 3           -- Global statusline

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Faster update
opt.updatetime = 200
opt.timeoutlen = 400

if vim.g.neovide then
  -- Font and size
  vim.opt.guifont = "JetBrainsMono Nerd Font:h11" -- or replace with your font

  -- Cursor settings: steady and smooth
  vim.g.neovide_cursor_vfx_mode = ""
  vim.g.neovide_cursor_trail_length = 0.1
  vim.g.neovide_cursor_antialiasing = true

  -- Remove any startup flash or shake
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_no_idle = false
  vim.g.neovide_opacity = 0.8

  -- Paste support
  vim.g.neovide_input_use_logo = true -- Enable Cmd/Ctrl shortcuts
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("i", "<D-v>", '<C-r>+') -- Paste insert mode
end
