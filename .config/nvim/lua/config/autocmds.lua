-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Set up an autocmd group for better management
local compile_group = vim.api.nvim_create_augroup("AutoCompileJava", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
	group = compile_group,
	pattern = "*.java",
	desc = "Auto-compile Java project when Java file is saved",
	callback = function()
		-- Use vim.fn.jobstart to avoid blocking the editor
		vim.fn.jobstart("javac -d out $(find src -name '*.java')", { detach = true })
	end,
})
