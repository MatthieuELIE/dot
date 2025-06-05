-- https://wezterm.org/
-- Pull in the wezterm API
local wezterm = require("wezterm")
local keys = require("keys")
local background = require("background")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config = {
	-- https://wezterm.org/config/lua/config/index.html
	animation_fps = 1,
	automatically_reload_config = false,
	color_scheme = "Catppuccin Mocha",
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	font = wezterm.font("JetBrainsMono Nerd Font"),
	front_end = "Software",
	harfbuzz_features = {
		"calt=0",
		"clig=0",
		"liga=0",
	},
	hide_tab_bar_if_only_one_tab = true,
	hyperlink_rules = {},
	keys = keys,
	max_fps = 60,
	scrollback_lines = 1000,
	show_new_tab_button_in_tab_bar = false,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	window_background_opacity = 1,
	-- window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	window_padding = {
		top = 0,
		right = 0,
		bottom = 0,
		left = 0,
	},
	background = background,
}

-- and finally, return the configuration to wezterm
return config
