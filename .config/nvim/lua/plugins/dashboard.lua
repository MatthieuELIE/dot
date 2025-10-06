--  Snacks.nvim Configuration
-- https://github.com/folke/snacks.nvim/blob/main/docs/dashboard.md#-dashboard

local utils = require("utils")

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
					function()
						local cmds = {
							{
								icon = " ",
								title = "Coworkers Merge Requests",
								key = "m",
								action = function()
									vim.ui.open(os.getenv("GITLAB_MR_URL") or "https://www.google.fr/")
								end,
								cmd = utils.glab_coworkers_mr(),
							},
						}
						return vim.tbl_map(function(cmd)
							return vim.tbl_extend("force", {
								section = "terminal",
								enabled = utils.git_enabled(),
								pane = 2,
								indent = 3,
								padding = 1,
								height = 5,
								ttl = 0,
							}, cmd)
						end, cmds)
					end,
				},
			},
		},
	},
}
