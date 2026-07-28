vim.pack.add({
    {
        src = 'https://github.com/MatthieuELIE/comment.nvim',
        version = 'v0.2.1',
    },
})

local comment = require('comment')

comment.setup({
    comments_only = true,
    line_hl_group = true,
    signs = {
        TODO = vim.fn.nr2char(0xf012c, true),
        NOTE = vim.fn.nr2char(0xf039a, true),
        FIX = vim.fn.nr2char(0xf05b7, true),
        HACK = vim.fn.nr2char(0xf01e5, true),
    },
})

vim.keymap.set('n', '<leader>tt', comment.insert.todo, { desc = 'Insert TODO comment' })
vim.keymap.set('n', '<leader>tn', comment.insert.note, { desc = 'Insert NOTE comment' })
vim.keymap.set('n', '<leader>tf', comment.insert.fix, { desc = 'Insert FIX comment' })
vim.keymap.set('n', '<leader>th', comment.insert.hack, { desc = 'Insert HACK comment' })
