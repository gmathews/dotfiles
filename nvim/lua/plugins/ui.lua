-- File navigation, management and ui
return {
	-- the colorscheme should be available when starting Neovim
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		opts = {
			contrast = "hard",
		},
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme gruvbox]])
		end,
	},
	{ "nvim-tree/nvim-web-devicons", opts = {} },
	{
		"nvim-tree/nvim-tree.lua",
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Nvim Tree" },
		},
		opts = {
			update_focused_file = {
				enable = true,
			},
			filters = {
				dotfiles = true,
				custom = { "node_modules" },
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "auto",
			},
			extensions = {
				{
					sections = {
						lualine_a = {
							function()
								return '"g?" for help'
							end,
						},
					},
					filetypes = { "NvimTree" },
				},
			},
			sections = {
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "filetype" },
			},
			tabline = {
				lualine_a = {
					{
						filetype_names = {
							TelescopePrompt = "Telescope",
							NvimTree = "File Explorer",
						},
						"buffers",
						hide_filename_extension = true,
						show_filename_only = false,
						mode = 4,
						max_length = vim.o.columns,
					},
				},
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim", -- branch = '0.1.x',
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && cmake --build build --config Release",
				config = function(plugin)
					require("telescope").load_extension("fzf")
				end,
			},
		},
		keys = {
			{ "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Find in Files" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	{ "akinsho/git-conflict.nvim", opts = {} },
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			scope = {
				show_start = false,
				show_end = false,
			},
		},
	},
}
