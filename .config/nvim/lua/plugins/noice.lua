-- https://github.com/folke/noice.nvim?tab=readme-ov-file#-noice-nice-noise-notice
return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	opts = {
		presets = {
			lsp_doc_border = true,
		},
		documentation = {
			view = "hover",
			opts = {
				border = "rounded",
			},
		},
	},
}
