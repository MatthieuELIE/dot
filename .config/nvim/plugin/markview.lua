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

-- Visual wrap only: VaultArchiveTodo (vault.nvim) needs each todo as one physical line.
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        vim.opt_local.textwidth = 0
    end,
})
