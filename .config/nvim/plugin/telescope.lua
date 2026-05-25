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
    },
    pickers = {
        find_files = {
            hidden = true,
        },
    },
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
