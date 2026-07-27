vim.pack.add({
    {
        src = 'https://github.com/MatthieuELIE/comment.nvim',
        version = 'v0.1.0',
    },
})

require('comment').setup({
    comments_only = true,
})

vim.keymap.set('n', '<leader>td', '<cmd>TodoInsert<cr>', { desc = 'Insert todo comment' })
