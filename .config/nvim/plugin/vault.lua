vim.pack.add({
    {
        src = 'https://github.com/MatthieuELIE/vault.nvim',
        version = 'main',
    },
})

local vault = vim.fn.expand(vim.env.VAULT_PATH)

require('vault').setup({
    split = 'edit',
    daily_path = vault .. '/01_DAILY_NOTES',
    todos_path = vault .. '/05_PROJECTS',
})
