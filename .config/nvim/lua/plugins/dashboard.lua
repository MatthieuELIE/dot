--  Snacks.nvim Configuration
-- https://github.com/folke/snacks.nvim/blob/main/docs/dashboard.md#-dashboard

return {
	{
		"folke/snacks.nvim",
		opts = {
			dashboard = {
				preset = {
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = ":lua Snacks.dashboard.pick('files')",
						},
						{
							icon = " ",
							key = "r",
							desc = "Recent Files",
							action = ":lua Snacks.dashboard.pick('oldfiles')",
						},
						{
							icon = " ",
							key = "s",
							desc = "Restore Session",
							section = "session",
						},
						{
							icon = " ",
							key = "q",
							desc = "Quit",
							action = ":qa",
						},
					},
				},
				sections = {
					{
						icon = " ",
						title = "Keymaps",
						section = "keys",
						indent = 3,
						padding = 1,
					},
					{
						icon = " ",
						title = "Git Status",
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = "git status --short",
						ttl = 0,
					},
					{
						icon = " ",
						title = "Merge Requests",
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = "glab mr list "
							.. "--not-draft "
							.. '--not-label "Parking,Threads" '
							.. "--output json | "
							.. "jq -r "
							.. "'(.[] | "
							.. "select(.labels | length != 0) | "
							.. "["
							.. '"\\u001b[31m" + (.iid | tostring) + "\\u001b[0m", '
							.. '"\\u001b[32m" + .author.name + "\\u001b[0m", '
							.. '(.title[:30] + (if .title | length > 30 then "..." else "" end))'
							.. "]) | "
							.. "@tsv' | "
							.. "column -t -s $'\t'",
						pane = 2,
						indent = 3,
						padding = 1,
						height = 5,
						ttl = 0,
					},
				},
			},
		},
	},
}
