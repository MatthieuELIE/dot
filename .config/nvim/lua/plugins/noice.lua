-- Noice.nvim configuration
-- GitHub: https://github.com/folke/noice.nvim
return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},

	opts = {
		-- Preset configurations for common use cases
		presets = {
			lsp_doc_border = true,
			command_palette = false,
			bottom_search = true,
		},

		-- Cmdline appearance and placement
		cmdline = {
			view = "cmdline",
			format = {
				cmdline = { icon = " " },
				filter = { icon = " " },
				search_down = { icon = " " },
				search_up = { icon = " " },
			},
		},

		-- Message display configuration
		messages = {
			view = "mini",
		},

		-- Custom views for various UI components
		views = {
			-- Cmdline view window position (relative from bottom)
			cmdline = {
				position = {
					row = -1,
				},
			},
		},

		-- Configuration for LSP hover documentation windows
		lsp = {
			hover = {
				opts = {
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
				},
			},
		},

		-- Message routing rules (filter out certain LSP progress messages)
		routes = {
			{
				-- Java LSP progress messages
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
