-- Quick save
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- Stay on home row: exit insert mode easily
vim.keymap.set('i', 'jj', '<ESC>', { desc = 'Exit Insert' })
vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Exit Insert' })
vim.keymap.set('i', 'kk', '<ESC>', { desc = 'Exit Insert' })
vim.keymap.set('i', 'kj', '<ESC>', { desc = 'Exit Insert' })

-- Vertical speed: jump 12 lines at a time
vim.keymap.set({ 'n', 'x' }, 'J', '}zz', { desc = 'Move Down Faster' })
vim.keymap.set({ 'n', 'x' }, 'K', '{zz', { desc = 'Move Up Faster' })

-- Keep cursor centered during search and jumps
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Prev search result' })

-- Smart line moving (handles counts and visual blocks)
vim.keymap.set('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
vim.keymap.set('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
vim.keymap.set('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
vim.keymap.set('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })

-- Editing improvements
vim.keymap.set('n', 'x', '"_x', { desc = 'Delete without yanking' })
vim.keymap.set('n', 'yig', 'ggVGy', { desc = 'Yank entire file' })
vim.keymap.set('v', 'p', '"_dP', { desc = 'Paste without overwriting clipboard' })

-- Buffer management
vim.keymap.set('n', '<Tab>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>%bd<CR>', { desc = 'Close all buffers' })
vim.keymap.set('n', '<leader>bo', '<cmd>%bd|e#|bd#<CR>', { desc = 'Close all but current buffer' })

-- Smooth window switching
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window', remap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window', remap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window', remap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window', remap = true })

vim.keymap.set('n', '<Esc>', function()
    return vim.v.hlsearch == 1 and '<cmd>nohlsearch<CR>' or '<Esc>'
end, { expr = true })

vim.keymap.set('n', '<leader>;', function()
    local commentstring = vim.bo.commentstring ~= '' and vim.bo.commentstring or '%s'
    local prefix, suffix = commentstring:match('^(.-)%%s(.*)$')
    local label = 'ANNOTATION: '

    vim.api.nvim_put({ prefix .. label .. suffix }, 'l', true, false)
    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], #(prefix .. label) })
    vim.cmd('startinsert')
end, { desc = 'Insert ANNOTATION comment' })
