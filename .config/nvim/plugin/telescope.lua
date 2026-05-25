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
        },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
    },
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-e>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '\\', builtin.live_grep, { desc = 'Telescope live grep' })
