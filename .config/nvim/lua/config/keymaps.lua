-- https://www.lazyvim.org/configuration/general#keymaps

-- Move faster
vim.keymap.set({ "n", "x" }, "J", "12j", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "K", "12k", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "H", "6h", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "L", "6l", { noremap = true, silent = true })

-- Set '-' to go to the end of the line in normal and visual modes
vim.keymap.set({ "n", "x" }, "-", "$", { noremap = true })
vim.keymap.set({ "n", "x" }, "0", "^", { noremap = true })

-- quit file
vim.keymap.set("n", "<C-q>", "<cmd> q <CR>", { noremap = true, silent = true })

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true })

-- Find and center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true })

-- Increment/decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>", { noremap = true, silent = true, desc = "Increment" }) -- increment
vim.keymap.set("n", "<leader>-", "<C-x>", { noremap = true, silent = true, desc = "Decrement" }) -- decrement

-- Press jk fast to exit insert mode
vim.keymap.set("i", "jj", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("i", "kk", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("i", "kj", "<ESC>", { noremap = true, silent = true })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', { noremap = true, silent = true })

-- Replace word under cursor
vim.keymap.set("n", "<leader>j", "*``cgn", { noremap = true, silent = true, desc = "Replace word under cursor" })

vim.keymap.set("n", "<Left>", "<c-w>h")
vim.keymap.set("n", "<Right>", "<c-w>l")
