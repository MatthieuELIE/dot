-- Neovim LSP configuration and custom keymaps
-- GitHub: https://github.com/neovim/nvim-lspconfig
return {
	-- Custom LSP keymaps configuration
	{
		"neovim/nvim-lspconfig",
		opts = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			-- Disable a keymap
			keys[#keys + 1] = { "K", false }
			-- Add a new keymap
			keys[#keys + 1] = { "<leader>K", require("noice.lsp").hover, desc = "Hover" }
		end,
	},
	-- LSP server setup configurations
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				-- Setup for denols LSP server with init options
				-- denols = {
				-- 	init_options = {
				-- 		enable = true,
				-- 		lint = true,
				-- 	},
				-- },
			},
		},
	},
}
