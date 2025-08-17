return {
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons", -- für Icons
		config = function()
			require("trouble").setup({
				fold_open = "",
				fold_closed = "",
				icons = {
					error = "",
					warning = "",
					hint = "",
					information = "",
				},
				use_diagnostic_signs = true,
			})

		end,
	},
}
