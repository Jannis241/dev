return {
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- für Icons
		config = function()
			require("trouble").setup({})

		end,
	},
}
