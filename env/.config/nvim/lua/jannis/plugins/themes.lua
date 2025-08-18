local function mach_transparent()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

	vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
	vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
	vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
end

local function apply_colorscheme(color)
	color = color or "rose-pine-moon"
	vim.cmd.colorscheme(color)
	-- mach_transparent()
end

return {
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
                options = {
                    transparent = true,
                }
			})
            -- namen: https://github.com/projekt0n/github-nvim-theme

            -- apply_colorscheme("github_dark_default")
		end,
	},
	{
		"Shatur/neovim-ayu",
		config = function()
			require("ayu").setup({
				mirage = false,
				terminal = true,
				overrides = {
					Normal = { bg = "None" },
					NormalFloat = { bg = "none" },
					ColorColumn = { bg = "None" },
					SignColumn = { bg = "None" },
					Folded = { bg = "None" },
					FoldColumn = { bg = "None" },
					-- CursorLine = { bg = "None" },
					-- CursorColumn = { bg = "None" },
					VertSplit = { bg = "None" },
					Comment = { italic = false },
				},
			})
			apply_colorscheme("ayu")
		end,
	},

	{
		"embark-theme/vim",
		as = "embark",
		config = function()
			-- apply_colorscheme("embark")
		end,
	},

	{
		"erikbackman/brightburn.vim",
		name = "bightburn",
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			-- apply_colorscheme("catppuccin")
		end,
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		name = "tokyonight",
		opts = {},
		config = function()
			-- apply_colorscheme("tokyonight")
		end,
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
				contrast = "hard", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = true,
			})
			-- apply_colorscheme("gruvbox")
		end,
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "moon",
				dark_variant = "moon",

				enable = {
					terminal = true,
					legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
					migrations = true, -- Handle deprecated options automatically
				},
				disable_background = true,
				styles = {
					italic = false,
					transparency = true,
				},
			})
			-- apply_colorscheme("rose-pine")
		end,
	},
}
