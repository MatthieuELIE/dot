vim.pack.add({
    { src = 'https://github.com/catppuccin/nvim' },
})

require('catppuccin').setup({
    flavour = 'mocha',
    transparent_background = true,

    integrations = {
        treesitter = true,
        lsp_semantic_tokens = true,
        neotree = {
            enabled = true,
            show_root = true,
            transparent_panel = false,
        },
    },

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

            NormalFloat = { bg = 'none' },
            FloatBorder = { bg = 'none' },
            Pmenu = { bg = 'none' },
        }
    end,
})

vim.cmd.colorscheme('catppuccin')
