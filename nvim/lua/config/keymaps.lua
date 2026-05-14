local non_hint_severity = {
	min = vim.diagnostic.severity.INFO, -- INFO, WARN, ERROR (excludes HINT)
	max = vim.diagnostic.severity.ERROR,
}

vim.keymap.set("n", "]e", function()
	vim.diagnostic.jump({ count = 1, severity = non_hint_severity })
end, { desc = "Next non-hint diagnostic" })

vim.keymap.set("n", "[e", function()
	vim.diagnostic.jump({ count = -1, severity = non_hint_severity })
end, { desc = "Previous non-hint diagnostic" })

-- Setup format (conform.nvim falls back to LSP for filetypes without a formatter)
vim.keymap.set("n", "<leader>p", function()
	require("conform").format({ async = false, lsp_format = "fallback" })
end, { desc = "Format buffer" })
vim.keymap.set("v", "<leader>p", function()
	require("conform").format({
		async = false,
		lsp_format = "fallback",
		range = {
			["start"] = vim.api.nvim_buf_get_mark(0, "<"),
			["end"] = vim.api.nvim_buf_get_mark(0, ">"),
		},
	})
end, { desc = "Format selection" })

-- Buffer management
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
