-- https://github.com/stevearc/conform.nvim
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	---@module "conform"
	---@type conform.setupOpts
	opts = (function()
		return {
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				lua = { "stylua" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				markdown = { "prettier" },
				sh = { "shfmt" },
				-- https://github.com/pamoller/xmlformatter
				xslt = {},
				xml = {},
			},

			formatters = {
				shfmt = {
					prepend_args = { "-i", "4", "-s" }, -- 4 spaces, use "-s" for spaces instead of tabs
				},
			},

			default_format_opts = {
				lsp_format = "fallback",
			},
		}
	end)(),
}
