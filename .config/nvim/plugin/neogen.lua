vim.pack.add({
    { src = 'https://github.com/danymat/neogen' },
})

require('neogen').setup({
    -- snippet_engine = 'mini',
})

vim.keymap.set('n', '<leader>cn', function()
    require('neogen').generate()
end, { desc = 'Generate Annotations' })
