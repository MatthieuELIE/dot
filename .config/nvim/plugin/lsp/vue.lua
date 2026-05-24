local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('volar', {
    capabilities = capabilities,
    cmd = { 'vue-language-server', '--stdio' },
    filetypes = { 'vue' },
    root_markers = { 'package.json', 'vue.config.js', 'vite.config.js', '.git' },
    settings = {
        vue = {
            hybridMode = true,
        },
    },
})

vim.lsp.enable('volar')
