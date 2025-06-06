-- https://wezterm.org/
local wezterm = require("wezterm")
local keys = require("keys")
local background = require("background")

local config = {
	-- https://wezterm.org/config/lua/config/index.html
	animation_fps = 1,
	automatically_reload_config = false,
	color_scheme = "Catppuccin Mocha",
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 12.5,
	front_end = "Software",
	hide_tab_bar_if_only_one_tab = true,
	hyperlink_rules = {},
	keys = keys,
	leader = {
		key = "Space",
		mods = "SHIFT",
		timeout_milliseconds = 500,
	},
	max_fps = 60,
	scrollback_lines = 1000,
	show_new_tab_button_in_tab_bar = false,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	window_decorations = "RESIZE",
	window_padding = {
		top = 0,
		right = 0,
		bottom = 0,
		left = 0,
	},
	background = background,
}

return config
