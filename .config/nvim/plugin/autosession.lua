vim.pack.add({
    { src = 'https://github.com/rmagatti/auto-session' },
})

local auto_session = require('auto-session')

auto_session.setup({
    auto_restore = false,
    auto_save = true,
    suppressed_dirs = { '~/', '~/Downloads' },
})

vim.keymap.set('n', '<leader>s', function()
    auto_session.restore_session()
end, { desc = 'Restore session' })
