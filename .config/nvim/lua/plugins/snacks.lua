-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#default
local defaultLayout = {
	layout = {
		box = "horizontal",
		width = 0.8,
		min_width = 120,
		height = 0.8,
		{
			box = "vertical",
			border = "rounded",
			title = "{title} {live} {flags}",
			{ win = "input", height = 1, border = "bottom" },
			{ win = "list", border = "none" },
		},
		{ win = "preview", title = "{preview}", border = "rounded", width = 0.7 },
	},
}

local exclude = {
	".git",
	".git/**",
	".vscode",
	".vscode/**",
	"dist",
	"dist/**",
	"node_modules",
	"node_modules/**",
	"logs",
	"logs/**",
	"playwright-report",
	"playwright-report/**",
	"test-results",
	"test-results/**",
	"**/*.sef.json",
	"**/documentation",
	"**/documentation/**",
	"**/*.class",
}

-- https://github.com/folke/snacks.nvim
return {
	{
		"folke/snacks.nvim",
		opts = {
			-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#-picker
			picker = {
				hidden = true, -- for hidden files
				ignored = true, -- for .gitignore files
				exclude = {
					".git",
					".git/**",
					".vscode",
					".vscode/**",
					"logs",
					"logs/**",
					"playwright-report",
					"playwright-report/**",
					"test-results",
					"test-results/**",
				},
				layout = {
					cycle = false,
				},
				formatters = {
					file = {
						filename_first = true,
						truncate = 60,
					},
				},
				sources = {
					-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#explorer
					explorer = {
						auto_close = true,
					},
					-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#files
					files = {
						hidden = true, -- for hidden files
						ignored = true, -- for .gitignore files
						exclude = exclude,
						layout = {
							preview = false,
							-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#select-1
							preset = "select",
						},
					},
					-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#grep
					grep = {
						hidden = true, -- for hidden files
						ignored = true, -- for .gitignore files
						exclude = exclude,
						layout = defaultLayout,
					},
					-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#git_diff
					git_diff = {
						layout = defaultLayout,
					},
					-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#git_log_line
					git_log_line = {
						layout = defaultLayout,
					},
				},
			},
		},
		keys = {
			{ "<leader>/", LazyVim.pick("grep", { root = false }), desc = "Grep" },
			{ "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files" },
		},
	},
}
