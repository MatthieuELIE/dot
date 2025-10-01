-- Autocommand configuration for Java and SCSS auto-compilation
-- LazyVim General Settings: https://www.lazyvim.org/configuration/general#auto-commands

-- Helper function to create autocmd groups with a standard prefix
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

		vim.fn.jobstart("javac -d out $(find src -name '*.java')", {
			detach = true,
			on_exit = function(_, code)
				if code ~= 0 then
					vim.notify("[Java] Compilation failed!", vim.log.levels.ERROR)
				else
					vim.notify("[Java] Compilation done!", vim.log.levels.INFO)
				end
			end,
		})
	end,
})

-- ---- SCSS Auto-Compilation ----
-- vim.api.nvim_create_autocmd("BufWritePost", {
-- 	group = augroup("BuildSCSS"),
-- 	pattern = "*.scss",
-- 	desc = "Auto-compile SCSS files on save",
-- 	callback = function()
-- 		if vim.fn.filereadable("package.json") == 0 then
-- 			vim.notify("[SCSS] No package.json found; skipping npm run scss", vim.log.levels.WARN)
-- 			return
-- 		end
--
-- 		vim.fn.jobstart("npm run build:scss", {
-- 			detach = true,
-- 			on_exit = function(_, code)
-- 				if code ~= 0 then
-- 					vim.notify("[SCSS] Compilation failed!", vim.log.levels.ERROR)
-- 				else
-- 					vim.notify("[SCSS] Compilation done!", vim.log.levels.INFO)
-- 				end
-- 			end,
-- 		})
-- 	end,
-- })
