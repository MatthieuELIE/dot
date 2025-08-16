-- Create a Neovim user command to format the current buffer using Prettier.
-- Usage: `:PrettierThisFile`
-- Requires Node.js and Prettier to be installed globally or in the project.
vim.api.nvim_create_user_command("PrettierThisFile", function()
	vim.cmd("!npx prettier -w %")
end, { desc = "Format the current file with Prettier" })
