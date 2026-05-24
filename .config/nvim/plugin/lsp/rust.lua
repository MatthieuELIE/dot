local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
