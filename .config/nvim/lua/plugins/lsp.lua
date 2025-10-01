local noiceLsp = require("noice.lsp")
-- Neovim LSP configuration and custom keymaps
-- GitHub: https://github.com/neovim/nvim-lspconfig
return {
	-- LSP server setup configurations
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				["*"] = {
					keys = {
						{ "K", false },
						{ "<leader>K", noiceLsp.hover, desc = "Hover" },
					},
				},
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
