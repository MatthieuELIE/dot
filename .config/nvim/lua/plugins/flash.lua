-- Flash configuration
-- GitHub: https://github.com/folke/flash.nvim
return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		-- Prompt appearance configuration
		prompt = {
			-- Prefix icon shown in the prompt input (requires a Nerd Font or compatible font)
			prefix = { { "  ", "FlashPromptIcon" } },
			-- Floating window configuration for the prompt input
			win_config = {
				row = -2,
			},
		},
	},
}
