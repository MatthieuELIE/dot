-- https://wezterm.org/config/lua/config/background.html?h=back
return {
	{
		source = {
			File = "/Users/" .. os.getenv("USER") .. "/.config/wezterm/kitty.jpg",
		},
		width = "100%",
		repeat_x = "NoRepeat",
	},
	{
		source = {
			Color = "rgba(28, 33, 39, 0.9)",
		},
		width = "100%",
		height = "100%",
	},
}
