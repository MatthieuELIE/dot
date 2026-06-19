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

local ignored_codes = {
    [6133] = true,
    [6196] = true,
    [6138] = true,
}

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

    handlers = {
        ['textDocument/publishDiagnostics'] = function(err, result, ctx, config)
            if result and result.diagnostics then
                result.diagnostics = vim.tbl_filter(function(d)
                    local code = tonumber(d.code) or d.code
                    return not ignored_codes[code]
                end, result.diagnostics)
            end

            vim.lsp.handlers['textDocument/publishDiagnostics'](err, result, ctx, config)
        end,
    },
})

vim.lsp.enable({
    'lua_ls',
    'rust_analyzer',
    'vtsls',
})
