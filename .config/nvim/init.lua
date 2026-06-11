-- Core configuration modules
require('options')
require('keymaps')
require('autocmds')

-- Plugin loading
require('pack')

-- Global diagnostic UI configuration
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
})

-- Floating windows (LSP hover, etc.) styling
-- Remove background to keep transparency and visual focus
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
