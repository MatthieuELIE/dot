vim.pack.add({
    { src = 'https://github.com/stevearc/conform.nvim' },
})

require('conform').setup({
    formatters_by_ft = {
        css = { 'prettier' },
        javascript = { 'prettier' },
        lua = { 'stylua' },
        markdown = { 'prettier' },
        rust = { 'rustfmt' },
        scss = { 'prettier' },
        typescript = { 'prettier' },
        vue = { 'prettier' },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
})
