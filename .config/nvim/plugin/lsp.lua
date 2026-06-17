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

vim.lsp.config('eslint', {
    capabilities = capabilities,
    cmd = { 'vscode-eslint-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    root_dir = function(path)
        return vim.fs.root(path, {
            '.eslintrc.js',
            '.eslintrc.json',
            'eslint.config.js',
            'eslint.config.ts',
        })
    end,
    settings = {
        eslint = {
            validate = 'on',
            rulesCustomizations = {},
            run = 'onType',
            nodePath = '',
            workingDirectories = { mode = 'auto' },
        },
    },
})

vim.lsp.config('vtsls', {
    capabilities = capabilities,
    cmd = { 'vtsls', '--stdio' },
    filetypes = { 'javascript', 'typescript', 'vue' },
    root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = '/opt/homebrew/lib/node_modules/@vue/typescript-plugin',
                        languages = { 'vue' },
                        configNamespace = 'typescript',
                        enableForWorkspaceTypeScriptVersions = true,
                    },
                },
            },
        },
    },
})

vim.lsp.enable({ 'lua_ls', 'rust_analyzer', 'eslint', 'vtsls' })
