local keymap = vim.keymap.set

-- Quick save
keymap({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- Stay on home row: exit insert mode easily
keymap('i', 'jj', '<ESC>', { desc = 'Exit Insert' })
keymap('i', 'jk', '<ESC>', { desc = 'Exit Insert' })
keymap('i', 'kk', '<ESC>', { desc = 'Exit Insert' })
keymap('i', 'kj', '<ESC>', { desc = 'Exit Insert' })

-- Better line navigation (Home/End behavior)
keymap({ 'n', 'x' }, 'H', '^', { desc = 'Go to start of line' })
keymap({ 'n', 'x' }, 'L', '$', { desc = 'Go to end of line' })

-- Vertical speed: jump 12 lines at a time
keymap({ 'n', 'x' }, 'J', '12j', { desc = 'Move Down Faster' })
keymap({ 'n', 'x' }, 'K', '12k', { desc = 'Move Up Faster' })

-- Keep cursor centered during search and jumps
keymap('n', 'n', 'nzzzv', { desc = 'Next search result' })
keymap('n', 'N', 'Nzzzv', { desc = 'Prev search result' })
keymap('n', '<C-m>', '`0', { desc = 'Return to last edit position' })

-- Smart line moving (handles counts and visual blocks)
keymap('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
keymap('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
keymap('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
keymap('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
keymap('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
keymap('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })

-- Editing improvements
keymap('n', 'x', '"_x', { desc = 'Delete without yanking' })
keymap('n', 'yig', 'ggVGy', { desc = 'Yank entire file' })
keymap('v', 'p', '"_dP', { desc = 'Paste without overwriting clipboard' })

-- Buffer management
keymap('n', '<Tab>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
keymap('n', '<S-Tab>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
keymap('n', '<leader>bo', '<cmd>%bd|e#|bd#<CR>', { desc = 'Close all but current buffer' })
keymap('n', '<C-w>', function() vim.cmd('bd') end, { desc = 'Delete current buffer' })

-- Smooth window switching
keymap('n', '<C-h>', '<C-w>h', { desc = 'Move to left window', remap = true })
keymap('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window', remap = true })
keymap('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window', remap = true })
keymap('n', '<C-l>', '<C-w>l', { desc = 'Move to right window', remap = true })
