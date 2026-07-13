vim.pack.add({
    { src = 'https://github.com/esmuellert/nvim-eslint' },
})

require('nvim-eslint').setup({
    filetypes = {
        'javascript',
        'typescript',
        'vue',
    },
    settings = {
        workingDirectory = {
            mode = 'location',
        },
    },
})
