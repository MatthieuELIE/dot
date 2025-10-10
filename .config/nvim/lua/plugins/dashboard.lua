--  Snacks.nvim Configuration
-- https://github.com/folke/snacks.nvim/blob/main/docs/dashboard.md#-dashboard

local gitlab = require("utils.gitlab")

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
						title = "Navigation",
						section = "keys",
						indent = 3,
						padding = 1,
					},
					{
						icon = " ",
						title = "Git",
						padding = { 0, 1, 0, 0 },
					},
					{
						icon = " ",
						key = "g",
						desc = "Open Projects",
						action = function()
							vim.ui.open(gitlab.GITLAB_HOST)
						end,
						indent = 3,
					},
					{
						icon = " ",
						key = "m",
						desc = "My Requests",
						action = function()
							vim.ui.open(gitlab.my_merge_requests())
						end,
						indent = 3,
					},
					{
						icon = " ",
						key = "n",
						desc = "Coworkers Requests",
						action = function()
							vim.ui.open(gitlab.coworker_merge_requests())
						end,
						indent = 3,
					},
				},
			},
		},
	},
}
