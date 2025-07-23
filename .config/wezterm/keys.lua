local wezterm = require("wezterm")

-- https://wezterm.org/config/lua/keyassignment/index.html
local keys = {
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
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "q",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
}

for i = 1, 8 do
	-- ALT + number to move to that position
	table.insert(keys, {
		key = tostring(i),
		mods = "ALT",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

return keys
