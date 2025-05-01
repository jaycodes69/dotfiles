return { 
    "ellisonleao/gruvbox.nvim",
    priority = 1000 ,
    config = function()
        local theme = require("gruvbox")
        theme.setup({
            terminal_colours = true,
            transparent_mode = true,
        })
        vim.o.background = "dark" -- or "light" for light mode
        vim.cmd([[colorscheme gruvbox]])
    end,
} 
