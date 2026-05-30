return {
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = true,
		priority = 1000,
		config = function()
			require("github-theme").setup({
				options = {
					transparent = true,
				},
			})
		end,
	},
	{
		"Shatur/neovim-ayu",
		lazy = true,
		priority = 1000,
		config = function()
			require("ayu").setup({
				mirage = false,
				terminal = true,
			})
		end,
	},
	{
		"embark-theme/vim",
		name = "embark",
		lazy = true,
		priority = 1000,
	},
	{
		"erikbackman/brightburn.vim",
		name = "brightburn",
		lazy = true,
		priority = 1000,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				background = {
					light = "latte",
					dark = "mocha",
				},
				transparent_background = true,
				float = {
					transparent = false,
					solid = true,
				},
				show_end_of_buffer = false,
				term_colors = false,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				no_italic = false,
				no_bold = false,
				no_underline = false,
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				lsp_styles = {
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
						ok = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
						ok = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
				default_integrations = true,
				auto_integrations = false,
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					notify = false,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
				},
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		lazy = true,
		priority = 1000,
		opts = {
			transparent = true,
			styles = {
				floats = "normal",
				sidebars = "transparent",
			},
		},
	},
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		lazy = true,
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true,
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
				inverse = true,
				contrast = "hard",
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = true,
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = true,
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				variant = "moon",
				dark_variant = "moon",
				enable = {
					terminal = true,
					legacy_highlights = true,
					migrations = true,
				},
				disable_background = true,
				styles = {
                    bold = false,
					italic = false,
					transparency = true,
				},
			})
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		lazy = true,
		priority = 1000,
		opts = {
			transparent = true,
			theme = "wave",
		},
	},
	{
		"EdenEast/nightfox.nvim",
		name = "nightfox",
		lazy = true,
		priority = 1000,
		opts = {
			options = {
				transparent = true,
			},
		},
	},
	{
		"navarasu/onedark.nvim",
		name = "onedark",
		lazy = true,
		priority = 1000,
		opts = {
			style = "dark",
			transparent = true,
		},
	},
	{
		"sainnhe/everforest",
		name = "everforest",
		lazy = true,
		priority = 1000,
		init = function()
			vim.g.everforest_background = "hard"
			vim.g.everforest_transparent_background = 1
		end,
	},
	{
		"Mofiqul/dracula.nvim",
		name = "dracula",
		lazy = true,
		priority = 1000,
		opts = {
			transparent_bg = true,
		},
	},
	{
		"shaunsingh/nord.nvim",
		name = "nord",
		lazy = true,
		priority = 1000,
		init = function()
			vim.g.nord_disable_background = true
		end,
	},
	{
		"Mofiqul/vscode.nvim",
		name = "vscode",
		lazy = true,
		priority = 1000,
		opts = {
			transparent = true,
		},
	},
	{
		"sainnhe/gruvbox-material",
		name = "gruvbox-material",
		lazy = true,
		priority = 1000,
		init = function()
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_transparent_background = 1
		end,
	},
	{
		"sainnhe/sonokai",
		name = "sonokai",
		lazy = true,
		priority = 1000,
		init = function()
			vim.g.sonokai_style = "andromeda"
			vim.g.sonokai_transparent_background = 1
		end,
	},
	{
		"sainnhe/edge",
		name = "edge",
		lazy = true,
		priority = 1000,
		init = function()
			vim.g.edge_style = "aura"
			vim.g.edge_transparent_background = 1
		end,
	},
	{
		"savq/melange-nvim",
		name = "melange",
		lazy = true,
		priority = 1000,
	},
	{
		"marko-cerovac/material.nvim",
		name = "material",
		lazy = true,
		priority = 1000,
		config = function()
			vim.g.material_style = "deep ocean"
			require("material").setup({
				disable = {
					background = true,
				},
			})
		end,
	},
	{
		"ribru17/bamboo.nvim",
		name = "bamboo",
		lazy = true,
		priority = 1000,
		opts = {
			transparent = true,
		},
	},
	{
		"rmehri01/onenord.nvim",
		name = "onenord",
		lazy = true,
		priority = 1000,
		opts = {
			theme = "dark",
			disable = {
				background = true,
			},
		},
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		name = "oxocarbon",
		lazy = true,
		priority = 1000,
	},
	{
		"AlexvZyl/nordic.nvim",
		name = "nordic",
		lazy = true,
		priority = 1000,
		opts = {
			transparent = true,
		},
	},
	{
		"dasupradyumna/midnight.nvim",
		name = "midnight",
		lazy = true,
		priority = 1000,
	},
	{
		"olivercederborg/poimandres.nvim",
		name = "poimandres",
		lazy = true,
		priority = 1000,
		opts = {
			disable_background = true,
		},
	},
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = true,
		priority = 1000,
		init = function()
			vim.g.moonflyTransparent = true
		end,
	},
	{
		"bluz71/vim-nightfly-colors",
		name = "nightfly",
		lazy = true,
		priority = 1000,
		init = function()
			vim.g.nightflyTransparent = true
		end,
	},
	{
		"challenger-deep-theme/vim",
		name = "challenger-deep",
		lazy = true,
		priority = 1000,
	},
	{
		"arzg/vim-colors-xcode",
		name = "xcode",
		lazy = true,
		priority = 1000,
	},
	{
		"tomasiser/vim-code-dark",
		name = "codedark",
		lazy = true,
		priority = 1000,
	},
	{
		"ramojus/mellifluous.nvim",
		name = "mellifluous",
		lazy = true,
		priority = 1000,
		opts = {
			transparent_background = {
				enabled = true,
			},
		},
	},
	{
		"rktjmp/lush.nvim",
		name = "lush",
		lazy = true,
		priority = 1000,
	},
	{
		"mcchrish/zenbones.nvim",
		name = "zenbones",
		lazy = true,
		priority = 1000,
		dependencies = {
			"rktjmp/lush.nvim",
		},
		config = function()
			vim.g.zenbones_transparent_background = true
		end,
	},
}
