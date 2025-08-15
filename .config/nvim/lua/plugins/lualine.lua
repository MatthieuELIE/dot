return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = {
		options = {
			theme = "catppuccin",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {
					"alpha",
					"dashboard",
					"snacks_dashboard",
				},
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				"branch",
				{
					"diff",
					colored = true,
					symbols = {
						added = LazyVim.config.icons.git.added,
						modified = LazyVim.config.icons.git.modified,
						removed = LazyVim.config.icons.git.removed,
					},
				},
			},
			lualine_c = {
				{
					LazyVim.lualine.pretty_path(),
				},
			},
			lualine_x = {
				{
					function()
						---@diagnostic disable-next-line: undefined-field
						return require("noice").api.status.command.get()
					end,
					cond = function()
						---@diagnostic disable-next-line: undefined-field
						return package.loaded["noice"] and require("noice").api.status.command.has()
					end,
					color = function()
						return {
							fg = Snacks.util.color("Statement"),
						}
					end,
				},
				{
					function()
						---@diagnostic disable-next-line: undefined-field
						return require("noice").api.status.mode.get()
					end,
					cond = function()
						---@diagnostic disable-next-line: undefined-field
						return package.loaded["noice"] and require("noice").api.status.mode.has()
					end,
					color = function()
						return {
							fg = Snacks.util.color("Constant"),
						}
					end,
				},
				{
					"filetype",
					icon_only = false,
					separator = "",
					padding = {
						left = 0,
						right = 1,
					},
				},
			},
		},
	},
}
