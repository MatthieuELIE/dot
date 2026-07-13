vim.pack.add({
    { src = 'https://github.com/nvim-lualine/lualine.nvim' },
    { src = 'https://github.com/nvim-mini/mini.icons' },
})

require('lualine').setup({
    options = {
        theme = 'catppuccin-nvim',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = {
            { 'mode', icon = ' ' },
        },
        lualine_b = {
            { 'branch', icon = ' ' },
            {
                'diff',
                symbols = {
                    added = ' ',
                    modified = ' ',
                    removed = ' ',
                },
            },
            'diagnostics',
        },
        lualine_c = {
            { 'filename', path = 1 },
        },
        lualine_x = {
            {
                'filetype',
                icon_only = false,
                padding = { left = 1, right = 1 },
            },
        },
        lualine_y = { 'progress' },
        lualine_z = {
            function()
                return '  ' .. os.date('%R')
            end,
        },
    },
})
