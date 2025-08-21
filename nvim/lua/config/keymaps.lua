-- Got next non-hint
vim.keymap.set("n", "]e", function()
	vim.diagnostic.goto_next({
		severity = {
			min = vim.diagnostic.severity.INFO, -- INFO, WARN, ERROR (excludes HINT)
			max = vim.diagnostic.severity.ERROR,
		},
	})
end, { desc = "Next non-hint diagnostic" })

-- Got prev non-hint
vim.keymap.set("n", "[e", function()
	vim.diagnostic.goto_prev({
		severity = {
			min = vim.diagnostic.severity.INFO,
			max = vim.diagnostic.severity.ERROR,
		},
	})
end, { desc = "Previous non-hint diagnostic" })

-- Setup format
vim.keymap.set("n", "<leader>p", vim.lsp.buf.format, { desc = "Format buffer" })
vim.keymap.set("v", "<leader>p", function()
	vim.lsp.buf.format({
		async = false,
		range = {
			["start"] = vim.api.nvim_buf_get_mark(0, "<"),
			["end"] = vim.api.nvim_buf_get_mark(0, ">"),
		},
	})
end, { desc = "Format selection" })
