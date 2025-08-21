-- Code navigation and diagnostics
return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			auto_install = true,
			ensure_installed = { "javascript", "jsdoc", "json", "lua", "vim", "typescript" },
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets" },

		-- use a release tag to download pre-built binaries
		version = "1.*",
		opts = {
			keymap = { preset = "enter" },
		},
	},
	{
		"mfussenegger/nvim-lint",
		opts = {
			-- Event to trigger linters
			events = { "BufWritePost", "BufWinEnter" },
			linters_by_ft = {
				javascript = { "eslint" },
				typescript = { "eslint" },
				-- Use the "*" filetype to run linters on all filetypes.
				-- ['*'] = { 'global linter' },
				-- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
				-- ['_'] = { 'fallback linter' },
				-- ["*"] = { "typos" },
			},
		},
		config = function(_, opts)
			local lint = require("lint")
			lint.linters_by_ft = opts.linters_by_ft

			vim.api.nvim_create_autocmd(opts.events, {
				group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
	{ "dmmulroy/ts-error-translator.nvim", opts = {} },
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
				},
			})
		end,
	},
}
