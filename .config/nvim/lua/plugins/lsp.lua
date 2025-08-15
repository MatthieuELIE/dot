return {
	-- LSP keymaps
	{
		"neovim/nvim-lspconfig",
		opts = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			-- disable a keymap
			keys[#keys + 1] = { "K", false }
			-- add / change a keymap
			keys[#keys + 1] = { "<leader>K", require("noice.lsp").hover, desc = "Hover" }
		end,
	},
	{
		-- LSP server configurations
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				ts_ls = {
					root_dir = require("lspconfig").util.root_pattern({ "package.json", "tsconfig.json" }),
					single_file_support = false,
					settings = {},
				},
				denols = {
					root_dir = require("lspconfig").util.root_pattern({ "deno.json", "deno.jsonc" }),
					single_file_support = false,
					init_options = {
						enable = true,
						lint = true,
					},
				},
			},
		},
	},
}
