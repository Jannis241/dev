return {
	{
		"Shatur/neovim-ayu",
		config = function()
			require("ayu").setup({
				mirage = false,
				terminal = false,
				overrides = {},
			})
            vim.cmd.colorscheme("ayu")
		end,
	},

	{
		"erikbackman/brightburn.vim",
		name = "bightburn",
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		name = "tokyonight",
		opts = {},
	},
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = false,
				bold = true,
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					operators = false,
					folds = false,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
		end,
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				styles = {
					italic = false,
				},
			})
		end,
	},


}
