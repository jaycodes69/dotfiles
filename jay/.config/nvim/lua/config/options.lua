-- [[ Basic Settings ]]
vim.opt.number = true            -- Show line numbers
vim.opt.relativenumber = true    -- Relative line numbers
vim.opt.cursorline = true        -- Highlight current line

vim.opt.termguicolors = true     -- True color support
vim.opt.mouse = "a"              -- Enable mouse in all modes
vim.opt.clipboard = "unnamedplus" -- System clipboard
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true          -- Persistent undo

vim.opt.scrolloff = 8            -- Keep lines above/below the cursor
vim.opt.sidescrolloff = 8

-- [[ Tabs & Indentation ]]
vim.opt.tabstop = 4              -- Number of spaces for a <Tab>
vim.opt.shiftwidth = 4           -- Number of spaces for autoindent
vim.opt.expandtab = true         -- Convert tabs to spaces
vim.opt.smartindent = true       -- Autoindent new lines

-- [[ Search ]]
vim.opt.ignorecase = true        -- Ignore case in search...
vim.opt.smartcase = true         -- ...unless you use uppercase
vim.opt.hlsearch = false         -- Don't highlight matches after search
vim.opt.incsearch = true         -- Highlight matches as you type

-- [[ Split Windows ]]
vim.opt.splitright = true        -- Vertical split to the right
vim.opt.splitbelow = true        -- Horizontal split below

-- [[ Folding (Tree-sitter) ]]
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99           -- Start with all folds open

-- [[ UI Enhancements ]]
vim.opt.signcolumn = "yes"       -- Show signcolumn always
vim.opt.colorcolumn = "100"      -- Guide for max line length

-- [[ Performance ]]
vim.opt.updatetime = 200         -- Faster completion
vim.opt.timeoutlen = 500         -- Mapped sequence timeout

-- [[ Completion Menu ]]
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Better autocompletion UI

-- [[ Filetype-based Plugin Activation ]]
vim.opt.fileencoding = "utf-8"   -- Consistent encoding
