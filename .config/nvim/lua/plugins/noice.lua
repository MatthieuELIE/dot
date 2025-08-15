-- https://github.com/folke/noice.nvim
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
			command_palette = false,
			bottom_search = true,
		},
		cmdline = {
			view = "cmdline",
		},
		messages = {
			view = "mini",
		},
		lsp = {
			hover = {
				opts = {
					border = {
						style = "rounded",
						padding = { 0, 1, 0, 1 },
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
			{
				filter = {
					event = "notify",
				},
				view = "mini",
			},
		},
	},
}
