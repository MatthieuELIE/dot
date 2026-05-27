vim.g.mapleader = ' '

vim.opt.clipboard = vim.env.SSH_CONNECTION and '' or 'unnamedplus'

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true

vim.opt.inccommand = 'split'

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.o.winborder = 'rounded'

vim.o.signcolumn = 'yes'

vim.opt.undofile = true
