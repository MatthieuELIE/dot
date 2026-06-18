-- Core configuration modules
require('options')
require('keymaps')
require('autocmds')

-- Global diagnostic UI configuration
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
})
