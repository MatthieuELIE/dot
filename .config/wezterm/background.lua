local wezterm = require("wezterm")

-- https://wezterm.org/config/lua/config/background.html?h=back
return {
	{
		source = {
			File = wezterm.home_dir .. "/.config/wezterm/kitty.jpg",
		},
		width = "100%",
		repeat_x = "NoRepeat",
	},
	{
		source = {
			Color = "rgba(24, 24, 37, 0.85)",
		},
		width = "100%",
		height = "100%",
	},
}
