-- Load the plugin (since it's in opt/)
vim.cmd('packadd nvim-treesitter')

-- Native Neovim Treesitter highlighting
-- This replaces the old nvim-treesitter.configs setup for newer/minimal versions
vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if lang then
            pcall(vim.treesitter.start, args.buf, lang)
        end
    end,
})

-- Minimal setup for the plugin itself
require('nvim-treesitter').setup({})
