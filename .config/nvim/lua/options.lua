-- Leader key
vim.g.mapleader = ' '

-- Clipboard
vim.opt.clipboard = vim.env.SSH_CONNECTION and '' or 'unnamedplus'

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Line numbers and UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.o.signcolumn = 'yes'

-- Command and search
vim.opt.inccommand = 'split'

-- Windows and layout
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.o.winborder = 'rounded'
vim.opt.laststatus = 3

-- Editing and completion
vim.opt.undofile = true
vim.opt.completeopt = 'menu,menuone,noselect'
