local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('eslint', {
    capabilities = capabilities,
    cmd = { 'vscode-eslint-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    root_markers = { '.eslintrc', '.eslintrc.js', '.eslintrc.json', 'eslint.config.js', 'package.json', '.git' },
    settings = {
        validate = 'on',
        rulesCustomizations = {},
        run = 'onType',
        nodePath = '',
        workingDirectory = { mode = 'auto' },
    },
})

vim.lsp.enable('eslint')
