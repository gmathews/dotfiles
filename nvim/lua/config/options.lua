-- Options are automatically loaded before lazy.nvim startup
-- Some nice options https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
local opt = vim.opt
-- yank and paste with the system clipboard
opt.clipboard = "unnamedplus"
-- setup indentation
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
-- ignore case if search pattern is all lowercase, case-sensitive otherwise
opt.ignorecase = true
opt.smartcase = true
-- line number
opt.number = true

opt.completeopt = "menu,menuone,noselect"
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
-- autocmd FileType * setlocal formatoptions-=r formatoptions-=o formatoptions+=j
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.laststatus = 3 -- global statusline
opt.showmode = false -- Dont show mode since we have a statusline
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.relativenumber = true -- Relative line numbers
opt.spelllang = { "en" }
opt.updatetime = 200 -- Save swap file and trigger CursorHold
-- Setup folding
opt.foldlevel = 99
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldmethod = "expr"
opt.colorcolumn = "100"
