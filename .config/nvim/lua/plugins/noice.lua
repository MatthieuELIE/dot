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
		lsp = {
			hover = {
				enabled = true,
				opts = {
					border = {
						style = "rounded",
						padding = { 0, 0, 0, 0 },
					},
				},
			},
		},
		routes = {
			{
				filter = {
					event = "lsp",
					kind = "progress",
					find = "jdtls",
				},
				opts = {
					skip = true,
				},
			},
		},
	},
}
