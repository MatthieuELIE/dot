vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', {}),
    desc = 'Hightlight selection on yank',
    pattern = '*',
    callback = function()
        vim.hl.on_yank({ higroup = 'IncSearch', timeout = 100 })
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'help',
    callback = function()
        vim.cmd('wincmd L')
        vim.cmd('vertical resize 100')
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
    end,
})
