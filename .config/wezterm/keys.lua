local wezterm = require("wezterm")

-- https://wezterm.org/config/lua/keyassignment/index.html
return {
	{
		-- Activate previous tab
		key = "[",
		mods = "CTRL",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		-- Activate next tab
		key = "]",
		mods = "CTRL",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "{",
		mods = "SHIFT|ALT",
		action = wezterm.action.MoveTabRelative(-1),
	},
	{
		key = "}",
		mods = "SHIFT|ALT",
		action = wezterm.action.MoveTabRelative(1),
	},
	{
		-- Open a new tab in the current pane's domain
		key = "T",
		mods = "SUPER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "w",
		mods = "SUPER",
		action = wezterm.action_callback(function(window, pane)
			local tab_count = #window:mux_window():tabs()
			if tab_count == 1 then
				-- Only one tab left, prompt for confirmation
				window:perform_action(wezterm.action.CloseCurrentTab({ confirm = true }), pane)
			else
				-- More than one tab, close without confirmation
				window:perform_action(wezterm.action.CloseCurrentTab({ confirm = false }), pane)
			end
		end),
	},
}
