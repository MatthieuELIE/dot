vim.pack.add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-mini/mini.icons',
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
})

-- https://github.com/MeanderingProgrammer/render-markdown.nvim
require('render-markdown').setup({
    render_modes = true,
    latex = { enabled = false },
    heading = {
        -- Replaces '#+' of 'atx_h._marker'.
        -- Output is evaluated depending on the type.
        icons = { '', '', '', '', '', '' },

        -- Added to the sign column if enabled.
        -- Output is evaluated by `cycle(value, context.level)`.
        signs = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },

        -- '#'s are concealed and icon is inlined on left side
        position = 'inline',
    },
    checkbox = {
        unchecked = {
            icon = '󰄰 ',
        },
        checked = {
            icon = '󰄴 ',
            scope_highlight = '@markup.strikethrough',
        },
    },
})
