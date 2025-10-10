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
							icon = " ",
							key = "m",
							desc = "My Merge Requests",
							action = function()
								vim.ui.open(gitlab.my_merge_requests())
							end,
						},
						{
							icon = " ",
							key = "n",
							desc = "Coworkers Merge Requests",
							action = function()
								vim.ui.open(gitlab.coworker_merge_requests())
							end,
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
				},
			},
		},
	},
}
