require('conform').setup({
    formatters_by_ft = {
        javascript = { 'prettier' },
        lua = { 'stylua' },
        markdown = { 'prettier' },
        rust = { 'rustfmt' },
        typescript = { 'prettier' },
        vue = { 'prettier' },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
})
