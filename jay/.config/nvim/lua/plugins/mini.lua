return {
    'echasnovski/mini.nvim',
    version = false,
    config = function()

        local basics = require("mini.basics")
        local pairs = require("mini.pairs")
        local statusline = require("mini.statusline")
        local indentline = require("mini.indentscope")
        local icons = require("mini.icons")

        basics.setup({
        })

        pairs.setup({
        })

        statusline.setup({
        })

        indentline.setup({
        })

        icons.setup({
        })

    end,
}
