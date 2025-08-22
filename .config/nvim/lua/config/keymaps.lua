-- Faster movement (jump multiple lines/chars at once)
vim.keymap.set({ "n", "x" }, "J", "12j", { noremap = true, silent = true, desc = "Move Down Faster" })
vim.keymap.set({ "n", "x" }, "K", "12k", { noremap = true, silent = true, desc = "Move Up Faster" })
vim.keymap.set({ "n", "x" }, "H", "6h", { noremap = true, silent = true, desc = "Move Left Faster" })
vim.keymap.set({ "n", "x" }, "L", "6l", { noremap = true, silent = true, desc = "Move Right Faster" })

-- Remap line navigation
vim.keymap.set({ "n", "x" }, "-", "$", { noremap = true, desc = "Go to End of Line" })
vim.keymap.set({ "n", "x" }, "0", "^", { noremap = true, desc = "Go to First Non-Blank" })

-- Center search results (keep cursor in middle line while searching)
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Search Result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev Search Result (centered)" })

-- Buffer Navigation
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next Buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Prev Buffer" })

-- Jump to the exact position of the last change in the current buffer
vim.keymap.set("n", "M", "`.zz", { desc = "Jump to exact last change" })

-- Jump to the cursor position when last leaving the buffer (`0 mark)
vim.keymap.set("n", "<C-m>", "`0", { desc = "Jump to last cursor position on buffer exit" })

-- Delete current buffer
vim.keymap.set("n", "Q", function()
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

-- Replace word under cursor quickly
vim.keymap.set("n", "<leader>j", "*``cgn", { noremap = true, silent = true, desc = "Replace word under cursor" })

-- Grep search in cwd
vim.keymap.set({ "n", "x" }, "S", function()
	Snacks.picker.grep({ root = false })
end, { noremap = true, silent = true, desc = "Grep Items (cwd)" })

-- Find files in cwd
vim.keymap.set({ "n", "x" }, "E", function()
	Snacks.picker.files({ root = false })
end, { noremap = true, silent = true, desc = "Find Files (cwd)" })
