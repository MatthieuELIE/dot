require('oil').setup({
    use_default_keymaps = false,
    view_options = {
        show_hidden = true,
    },
    keymaps = {
        ['<CR>'] = 'actions.select',
        ['<C-p>'] = 'actions.preview',
        ['<C-c>'] = { 'actions.close', mode = 'n' },
        ['-'] = { 'actions.parent', mode = 'n' },
    },
})

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
