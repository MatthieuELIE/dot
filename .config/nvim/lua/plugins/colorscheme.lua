-- LazyVim and Catppuccin colorscheme configuration
-- GitHub: https://github.com/catppuccin/nvim
return {
	{
		"LazyVim/LazyVim",
		opts = {
			-- Set the colorscheme using Catppuccin
			colorscheme = function()
				require("catppuccin").load()
			end,
		},
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		-- Ensure Catppuccin loads early to avoid conflicts
		priority = 1000,
		opts = {
			flavour = "mocha",
			transparent_background = true,
			auto_integrations = true,
			float = {
				transparent = true,
			},
		},
	},
}
