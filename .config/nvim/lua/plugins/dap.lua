-- Nvim-dap configuration for JavaScript and TypeScript debugging
-- GitHub: https://github.com/mfussenegger/nvim-dap
return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			-- Define the debug adapter for "pwa-node" (Node.js debugger)
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = 43229,
				-- Executable configuration to launch the debug server
				executable = {
					command = "node",
					args = {
						-- Path to the DAP debug server script installed via Mason
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"43229",
					},
					detached = false,
				},
			}
			-- JavaScript debug configurations
			dap.configurations.javascript = {
				{
					name = "Launch file",
					type = "pwa-node",
					request = "launch",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					name = "Attach to process",
					type = "pwa-node",
					request = "attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
			-- Use the same debug configurations for TypeScript as for JavaScript
			dap.configurations.typescript = dap.configurations.javascript
		end,
	},
}
