return {
	dir = "~/dev/gitgraph.nvim/",
	name = "gitgraph",
	dev = true,
	keys = {
		{
			"<leader>gm",
			function()
				require("gitgraph").open()
			end,
			desc = "Open Gitgraph",
		},
	},
}
