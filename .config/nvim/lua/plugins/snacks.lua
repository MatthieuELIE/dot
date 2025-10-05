--  Snacks.nvim Configuration
--  https://github.com/folke/snacks.nvim

-- Shared Layouts
local dropdownLayout = {
	preview = false,
	preset = "dropdown",
	layout = {
		height = 0.4,
	},
}

local horizontalLayout = {
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
		{ win = "preview", title = "{preview}", border = "rounded", width = 0.6 },
	},
}

-- Shared Exclude Patterns
local exclude = {
	".git",
	".git/**",
	".vscode",
	".vscode/**",
	"node_modules",
	"node_modules/**",
	"dist",
	"dist/**",
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

-- Plugin Setup
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
				},
			},
			picker = {
				-- Global settings
				hidden = true, -- include hidden files
				ignored = true, -- respect .gitignore
				exclude = exclude,
				layout = {
					cycle = false, -- disable cycling layouts
				},
				formatters = {
					file = {
						filename_first = true,
						truncate = 60,
					},
				},
				-- Source-specific settings
				sources = {
					-- Buffers picker
					buffers = {
						layout = dropdownLayout,
					},
					-- File Explorer
					explorer = {
						auto_close = true,
					},
					-- Files picker
					files = {
						hidden = true,
						ignored = true,
						exclude = exclude,
						layout = dropdownLayout,
					},
					-- Recent files picker
					recent = {
						hidden = true,
						ignored = true,
						exclude = exclude,
						layout = dropdownLayout,
					},
					-- Git-related pickers
					git_diff = { layout = horizontalLayout },
					git_log = { layout = horizontalLayout },
					git_log_line = { layout = horizontalLayout },
					git_status = { layout = horizontalLayout },
					-- Grep / Search
					grep = {
						hidden = true,
						ignored = true,
						exclude = exclude,
						layout = horizontalLayout,
					},
				},
			},
		},
		-- Snacks Keymaps
		keys = {
			-- Disable Snacks default
			{ "<leader>/", false },
			{ "<leader>,", false },
			-- Buffers picker
			{
				"<leader><leader>",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{ "<leader>bd", "<Cmd>:%bd<CR>", desc = "Delete all buffers" },
		},
	},
}
