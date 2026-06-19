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
