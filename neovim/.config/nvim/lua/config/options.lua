-- options.lua

-- [[ Leader Key Configuration ]]
vim.g.mapleader = ' '            -- Set <Space> as the leader key
vim.g.maplocalleader = ' '       -- Set <Space> as the local leader key

-- [[ General Settings ]]
vim.opt.number = true            -- Show absolute line numbers
vim.opt.relativenumber = true    -- Show relative line numbers
vim.opt.mouse = 'a'              -- Enable mouse support in all modes
vim.opt.hlsearch = false         -- Disable highlight on search
vim.opt.breakindent = true       -- Enable break indent
vim.opt.undofile = true          -- Enable persistent undo
vim.opt.ignorecase = true        -- Ignore case in search patterns
vim.opt.smartcase = true         -- Override ignorecase if search pattern contains uppercase letters
vim.opt.updatetime = 250         -- Faster completion
vim.opt.timeoutlen = 300         -- Time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.signcolumn = 'yes'       -- Always show the sign column
vim.opt.confirm = true           -- Confirm to save changes before exiting modified buffer

-- [[ Appearance ]]
vim.opt.termguicolors = true     -- Enable true color support
vim.opt.scrolloff = 8            -- Minimum number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8        -- Minimum number of screen columns to keep to the left and right of the cursor
vim.opt.cursorline = true        -- Highlight the current line
vim.opt.inccommand = "split"
vim.opt.virtualedit = "block"
vim.opt.wrap = false             -- Display long lines as just one line

-- [[ Tabs and Indentation ]]
vim.opt.expandtab = true         -- Convert tabs to spaces
vim.opt.tabstop = 4              -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4           -- Size of an indent
vim.opt.softtabstop = 4
vim.opt.smartindent = true       -- Smart autoindenting when starting a new line
vim.opt.breakindent = true
vim.opt.smarttab = true

vim.opt.showmode = false
-- [[ Clipboard ]]
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard

-- [[ Split Windows ]]
vim.opt.splitright = true        -- Vertical splits will automatically be to the right
vim.opt.splitbelow = true        -- Horizontal splits will automatically be below

-- [[ Completion Options ]]
vim.opt.completeopt = { 'menuone', 'noselect' } -- Better completion experience

-- [[ File Encoding ]]
vim.opt.encoding = 'utf-8'       -- Set default encoding to UTF-8
vim.opt.fileencoding = 'utf-8'   -- File content encoding for the buffer

-- [[ Backspace Behavior ]]
vim.opt.backspace = { 'indent', 'eol', 'start' } -- Allow backspacing over everything in insert mode

-- [[ Yank Highlight ]]
-- Highlight yanked text for better visual feedback
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
  end,
})

