local noiceLsp = require("noice.lsp")
-- Neovim LSP configuration and custom keymaps
-- GitHub: https://github.com/neovim/nvim-lspconfig
return {
	-- LSP server setup configurations
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = {
				enabled = false,
			},
			servers = {
				["*"] = {
					keys = {
						{ "K", false },
						{ "<leader>K", noiceLsp.hover, desc = "Hover" },
					},
				},
			},
		},
	},
}
