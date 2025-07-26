return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

        telescope.setup {
            defaults = {
                mappings = {
                    i = {
                        ["<C-h>"] = "which_key",
                    },
                },
            },
            pickers = {
                -- Configure specific pickers here if needed
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            }
        }

        -- Load the fzf extension
        telescope.load_extension('fzf')
    end

}
