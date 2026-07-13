vim.pack.add({
    { src = 'https://github.com/nvim-telescope/telescope.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
})

require('telescope').setup({
    defaults = {
        layout_strategy = 'horizontal',
        layout_config = {
            horizontal = {
                preview_width = 0.6,
                results_width = 0.4,
                width = 0.9,
                height = 0.9,
            },
        },

        file_ignore_patterns = {
            '%.git/',
            'node_modules/',
            'public/',
            '**.class',
        },
    },

    pickers = {
        find_files = {
            hidden = true,
        },

        live_grep = {
            additional_args = function()
                return { '--hidden' }
            end,
        },

        grep_string = {
            additional_args = function()
                return { '--hidden' }
            end,
        },
    },
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-e>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '\\', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Telescope live grep' })
