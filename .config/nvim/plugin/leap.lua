vim.pack.add({
    { src = 'https://codeberg.org/andyg/leap.nvim' },
})

vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)')
vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)')
