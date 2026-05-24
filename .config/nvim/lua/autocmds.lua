vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('highlight_yank', {}),
	desc = 'Hightlight selection on yank',
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 100 })
	end,
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
		end

		map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
		map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
		map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
		map('n', 'gr', vim.lsp.buf.references, 'Go to references')

		map('n', '<leader>k', vim.lsp.buf.hover, 'Hover documentation')
		map('n', 'gs', vim.lsp.buf.signature_help, 'Signature help')

		map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
		map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')

		map('n', '<leader>d', vim.diagnostic.open_float, 'Open diagnostic float')
		map('n', '<leader>q', vim.diagnostic.setloclist, 'Diagnostics to loclist')
		map('n', '[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
		map('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic')
	end,
})
