return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {
            -- Languages
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "markdown",
                "markdown_inline",
                "bash",
                "python",
                "json",
                "html",
                "cpp"
            },

            sync_install = false,
            auto_install = true,

            -- Syntax highlighting
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            -- Incremental selection
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<leader><CR>",
                    node_incremental = "<CR>",
                    -- scope_incremental = "grc",
                    node_decremental = "<BS>",
                },
            },

            -- Indentation (experimental)
            indent = {
                enable = true,
            },

            -- Optional: Add more modules like textobjects, playground, rainbow, etc.
        }

        -- Optional: Treesitter folding
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        -- Optional: Open all folds by default
        vim.opt.foldlevel = 99
    end,
}
