-- https://www.lazyvim.org/configuration/general#auto-commands
-- Define a central helper for creating autocmd groups
local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- ---- Java Auto-Compilation ----
vim.api.nvim_create_autocmd("BufWritePost", {
	group = augroup("AutoCompileJava"),
	pattern = "*.java",
	desc = "Auto-compile Java project on save",
	callback = function()
		if vim.fn.isdirectory("src") == 0 then
			vim.notify("[Java] 'src' directory not found; skipping compilation", vim.log.levels.WARN)
			return
		end
		local cmd = "javac -d out $(find src -name '*.java')"
		-- https://neovim.io/doc/user/vimfn.html#jobstart()
		vim.fn.jobstart(cmd, {
			detach = true,
			on_exit = function(_, code)
				if code ~= 0 then
					vim.notify("[Java] Compilation failed !", vim.log.levels.ERROR)
				end
				vim.notify("[Java] Compilation done !", vim.log.levels.INFO)
			end,
		})
	end,
})

-- ---- SCSS Auto-Compilation ----
vim.api.nvim_create_autocmd("BufWritePost", {
	group = augroup("BuildSCSS"),
	pattern = "*.scss",
	desc = "Auto-compile SCSS files on save",
	callback = function()
		if vim.fn.filereadable("package.json") == 0 then
			vim.notify("[SCSS] No package.json found; skipping npm run scss", vim.log.levels.WARN)
			return
		end
		-- https://neovim.io/doc/user/vimfn.html#jobstart()
		vim.fn.jobstart("npm run build:scss", {
			detach = true,
			on_exit = function(_, code)
				if code ~= 0 then
					vim.notify("[SCSS] Compilation failed !", vim.log.levels.ERROR)
				end
				vim.notify("[SCSS] Compilation done !", vim.log.levels.INFO)
			end,
		})
	end,
})
