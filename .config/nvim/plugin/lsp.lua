local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('lua_ls', {
    capabilities = capabilities,
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.git' },
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            telemetry = { enable = false },
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file('', true),
            },
        },
    },
})
vim.lsp.enable({ 'lua_ls' })

vim.lsp.config('rust_analyzer', {
    capabilities = capabilities,
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml', 'Cargo.lock', '.git' },
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = true,
        },
    },
})
vim.lsp.enable('rust_analyzer')

vim.lsp.config('ts_ls', {
    capabilities = capabilities,
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'javascript', 'typescript' },
    root_markers = { 'package.json', 'tsconfig.json', '.git' },
})
vim.lsp.enable('ts_ls')

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
