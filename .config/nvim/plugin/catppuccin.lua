require('catppuccin').setup({
    flavour = 'mocha',
    transparent_background = true,

    custom_highlights = function(colors)
        return {
            TelescopeNormal = { bg = 'none' },
            TelescopeBorder = { bg = 'none' },

            TelescopePromptNormal = { bg = 'none' },
            TelescopeResultsNormal = { bg = 'none' },
            TelescopePreviewNormal = { bg = 'none' },

            TelescopePromptTitle = { bg = 'none', fg = colors.red },
            TelescopeResultsTitle = { bg = 'none', fg = colors.green },
            TelescopePreviewTitle = { bg = 'none', fg = colors.mauve },
        }
    end,
})

vim.cmd.colorscheme('catppuccin')
