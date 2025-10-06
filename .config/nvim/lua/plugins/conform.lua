-- Conform configuration
-- GitHub: https://github.com/stevearc/conform.nvim
return {
	"stevearc/conform.nvim",
	-- Load on buffer write (save) and when user runs :ConformInfo command
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		-- Map filetypes to formatters to run on those filetypes
		formatters_by_ft = {
			javascript = { "prettier" },
			typescript = { "prettier" },
			lua = { "stylua" },
			css = { "prettier" },
			scss = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			markdown = { "prettier" },
			sh = { "shfmt" },
		},
		-- Default formatting options
		default_format_opts = {
			-- Use LSP formatter only as a fallback if no formatter is available
			lsp_format = "fallback",
		},
	},
}
