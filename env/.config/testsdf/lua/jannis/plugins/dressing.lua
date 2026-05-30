return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	opts = {
		input = {
			border = "rounded",
			relative = "cursor",
			win_options = {
				winblend = 0,
			},
		},
		select = {
			backend = { "telescope", "builtin" },
			builtin = {
				border = "rounded",
				win_options = {
					winblend = 0,
				},
			},
		},
	},
}
