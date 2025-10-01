--  Snacks.nvim Configuration
-- https://github.com/folke/snacks.nvim/blob/main/docs/dashboard.md#-dashboard

-- local Job = require("plenary.job")
--
-- Job:new({
-- 	command = "git",
-- 	args = {
-- 		"config",
-- 		"get",
-- 		"remote.origin.url",
-- 	},
-- 	on_exit = function(j, return_val)
-- 		vim.notify(j:result()[1])
-- 	end,
-- }):sync()

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
								title = "Merge Requests",
								section = "terminal",
								enabled = function()
									return Snacks.git.get_root() ~= nil
								end,
								cmd = 'glab mr list --not-draft --not-label "Parking,Threads" --output json | jq -r \'(.[] | select(.labels | length != 0) | [.iid, .author.name, (.title[:30] + (if .title | length > 30 then "..." else "" end))]) | @tsv\' | column -t -s $\'\t\'',
							},
						}
						return vim.tbl_map(function(cmd)
							return vim.tbl_extend("force", {
								section = "terminal",
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
