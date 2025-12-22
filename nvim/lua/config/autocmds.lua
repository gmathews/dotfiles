local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("enable_spellcheck"),
	pattern = { "markdown", "tex", "text", "gitcommit", "mail" },
	callback = function()
		vim.opt_local.spell = true
	end,
})
-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})
-- Display linting errors
vim.api.nvim_create_autocmd("CursorHold", {
	group = augroup("diagnostic"),
	pattern = { "*.ts", "*.js", "*.cs" },
	callback = function(args)
		vim.diagnostic.open_float(args.buf, { scope = "cursor", focus = false })
	end,
})
-- Set up keymaps when LSP attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf

		-- Only set up keymaps for supported capabilities
		if client.server_capabilities.definitionProvider then
			-- Goto definition
			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, { buffer = bufnr, desc = "Goto Definition" })
			-- List references
			vim.keymap.set("n", "gr", function()
				vim.lsp.buf.references()
			end, { buffer = bufnr, desc = "List References" })
			-- Rename symbol
			vim.keymap.set("n", "<leader>rn", function()
				vim.lsp.buf.rename()
			end, { buffer = bufnr, desc = "Rename Symbol" })
			-- Code actions
			vim.keymap.set("n", "<leader>ca", function()
				vim.lsp.buf.code_action()
			end, { buffer = bufnr, desc = "Code Actions" })
		end
	end,
})
