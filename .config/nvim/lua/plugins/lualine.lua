-- lualine.nvim statusline configuration using Catppuccin theme
-- GitHub: https://github.com/nvim-lualine/lualine.nvim
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
			lualine_a = {
				{
					"mode",
					icon = " ",
				},
			},
			lualine_b = {
				{
					"branch",
					icon = " ",
				},
				{
					"diff",
					colored = true,
					symbols = {
						added = " ",
						modified = " ",
						removed = " ",
					},
				},
			},
			lualine_c = {
				{
					-- Show pretty file path using LazyVim util function
					LazyVim.lualine.pretty_path(),
				},
			},
			lualine_x = {
				{
					-- Show Noice command status if available
					function()
						---@diagnostic disable-next-line: undefined-field
						return require("noice").api.status.command.get()
					end,
					cond = function()
						---@diagnostic disable-next-line: undefined-field
						return package.loaded["noice"] and require("noice").api.status.command.has()
					end,
					color = function()
						return { fg = Snacks.util.color("Statement") }
					end,
				},
				{
					-- Show Noice mode status if available
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
					padding = { left = 0, right = 1 },
				},
			},
			lualine_z = {
				function()
					return "  " .. os.date("%R")
				end,
			},
		},
	},
}
