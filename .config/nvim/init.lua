require("options")
require("keymaps")
require("autocmds")

require("pack")

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
})
