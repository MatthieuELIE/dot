local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('ts_ls', {
    capabilities = capabilities,
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'javascript', 'typescript' },
    root_markers = { 'package.json', 'tsconfig.json', '.git' },
})

vim.lsp.enable('ts_ls')
