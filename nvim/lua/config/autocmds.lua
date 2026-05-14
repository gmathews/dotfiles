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
		vim.hl.on_yank()
	end,
})
vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = true },
})

-- Show diagnostic float on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
	group = augroup("diagnostic"),
	callback = function(args)
		vim.diagnostic.open_float(args.buf, { scope = "cursor", focus = false })
	end,
})
-- Set up keymaps when LSP attaches to a buffer.
-- Note: Neovim 0.11+ ships defaults for grr (references), gri (implementation),
-- grn (rename), gra (code action), gO (document symbol), K (hover).
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf

		if client.server_capabilities.definitionProvider then
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Goto Definition" })
		end
	end,
})
