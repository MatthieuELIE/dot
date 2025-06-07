return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = function()
				require("catppuccin").load()
			end,
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "mocha",
			transparent_background = true,
			float = {
				transparent = true,
			},
			integrations = {
				telescope = {
					enabled = true,
				},
				dropbar = {
					enabled = true,
					color_mode = true,
				},
			},
		},
	},
}
