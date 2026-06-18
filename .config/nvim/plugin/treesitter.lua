vim.pack.add({
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
})

-- Minimal setup for the plugin itself
require('nvim-treesitter').setup({
    install_dir = vim.fn.stdpath('data') .. '/site',
})

-- Native Neovim Treesitter highlighting
-- This replaces the old nvim-treesitter.configs setup for newer/minimal versions
vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if lang then
            pcall(vim.treesitter.start, args.buf, lang)
        end

        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
