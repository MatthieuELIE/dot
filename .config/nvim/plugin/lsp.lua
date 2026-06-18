vim.pack.add({
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local npm_root = vim.fn.system('npm root -g'):gsub('%s+', '')

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

vim.lsp.config('vue_ls', {
    capabilities = capabilities,
    filetypes = { 'vue' },
    root_markers = { 'package.json', '.git' },
    init_options = {
        vue = {
            hybridMode = true,
        },
        typescript = {
            tsdk = npm_root .. '/typescript/lib',
        },
    },
})

vim.lsp.config('ts_ls', {
    capabilities = capabilities,
    filetypes = { 'javascript', 'typescript', 'vue' },
    root_markers = { 'package.json', '.git' },
    init_options = {
        plugins = {
            {
                name = '@vue/typescript-plugin',
                location = npm_root .. '/@vue/typescript-plugin',
                languages = { 'javascript', 'typescript', 'vue' },
            },
        },
    },
})

vim.lsp.config('cssls', {
    capabilities = capabilities,
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    root_markers = { 'package.json', '.git' },
    settings = {
        css = { validate = true },
        scss = { validate = true },
        less = { validate = true },
    },
})

vim.lsp.enable({
    'lua_ls',
    'rust_analyzer',
    'vue_ls',
    'ts_ls',
    'cssls',
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
        end

        map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
        map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
        map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
        map('n', 'gr', vim.lsp.buf.references, 'Go to references')

        map('n', 'H', vim.lsp.buf.hover, 'Hover documentation')
        map('n', 'gs', vim.lsp.buf.signature_help, 'Signature help')
        map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')

        map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
        map('n', '<leader>cA', function()
            return vim.lsp.buf.code_action({
                context = {
                    only = {
                        'source',
                    },
                    diagnostics = vim.diagnostic.get(0),
                },
                apply = true,
            })
        end, 'Code action')

        map('n', '<leader>d', vim.diagnostic.open_float, 'Open diagnostic float')
        map('n', '<leader>q', vim.diagnostic.setloclist, 'Diagnostics to loclist')
        map('n', '[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
        map('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic')
    end,
})
