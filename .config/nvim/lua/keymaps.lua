-- Faster movement (jump multiple lines/chars at once)
vim.keymap.set({ "n", "x" }, "J", "12j", { noremap = true, silent = true, desc = "Move Down Faster" })
vim.keymap.set({ "n", "x" }, "K", "12k", { noremap = true, silent = true, desc = "Move Up Faster" })
vim.keymap.set({ "n", "x" }, "H", "6h", { noremap = true, silent = true, desc = "Move Left Faster" })
vim.keymap.set({ "n", "x" }, "L", "6l", { noremap = true, silent = true, desc = "Move Right Faster" })

-- Remap line navigation
vim.keymap.set({ "n", "x" }, "H", "^", { noremap = true, desc = "Go to First Non-Blank" })
vim.keymap.set({ "n", "x" }, "L", "$", { noremap = true, desc = "Go to End of Line" })

-- Center search results (keep cursor in middle line while searching)
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Search Result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev Search Result (centered)" })

-- Buffer Navigation
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next Buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Prev Buffer" })

-- Jump to the cursor position when last leaving the buffer (`0 mark)
vim.keymap.set("n", "<C-m>", "`0", { desc = "Jump to last cursor position on buffer exit" })

-- Delete current buffer
vim.keymap.set("n", "<C-w>", function()
	vim.cmd("bd")
end, { noremap = true, silent = true, desc = "Delete current buffer" })

-- Easily exit insert mode with jk/jj/kk/kj combos
vim.keymap.set("i", "jj", "<ESC>", { noremap = true, silent = true, desc = "Exit Insert" })
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "Exit Insert" })
vim.keymap.set("i", "kk", "<ESC>", { noremap = true, silent = true, desc = "Exit Insert" })
vim.keymap.set("i", "kj", "<ESC>", { noremap = true, silent = true, desc = "Exit Insert" })

-- Delete single char without yanking into default register
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true, desc = "Delete Char (no yank)" })

-- Move selected lines up/down (Visual Mode)
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move Line Down" })
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move Line Up" })

-- Keep last yanked text when pasting (don't overwrite clipboard)
vim.keymap.set("v", "p", '"_dP', { noremap = true, silent = true, desc = "Paste Without Overwriting Yank" })

-- Save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
