return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,

		config = function()
			local parsers = {
				"lua",
				"vim",
				"html",
				"css",
				"json",
				"gitignore",
				"go",
				"bash",
				"cpp",
				"java",
				"python",
				"c",
				"rust",
				"markdown",
				"markdown_inline",
			}

			require("nvim-treesitter").install(parsers)
		end,
	},
}
