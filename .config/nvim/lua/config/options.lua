-- https://www.lazyvim.org/configuration/general#options

vim.g.snacks_animate = false -- Snacks animations
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.tabstop = 4 -- Number of spaces tabs count for
vim.opt.inccommand = "split" -- preview incremental substitute

-- Syntax highlighting for fenced code blocks in markdown
vim.g.markdown_fenced_languages = {
	"ts=typescript",
}
