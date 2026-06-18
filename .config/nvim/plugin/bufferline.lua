vim.pack.add({
    { src = 'https://github.com/catppuccin/nvim' },
    { src = 'https://github.com/nvim-mini/mini.icons' },
    { src = 'https://github.com/akinsho/bufferline.nvim' },
})

require('bufferline').setup({
    options = {
        separator_style = 'thin',
        diagnostics = 'nvim_lsp',
        show_buffer_close_icons = false,
        show_close_icon = false,
        always_show_bufferline = false,
    },
    highlights = require('catppuccin.special.bufferline').get_theme({}),
})
