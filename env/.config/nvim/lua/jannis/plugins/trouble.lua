return {
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{
				"<leader>xf",
				function()
					require("trouble").toggle({
						mode = "diagnostics",
						focus = false,
						pinned = true,
						filter = {
							buf = 0,
							severity = vim.diagnostic.severity.ERROR,
						},
						win = {
							position = "right",
							size = 45,
						},
					})
				end,
				desc = "File errors",
			},
			{
				"<leader>xp",
				function()
					require("trouble").toggle({
						mode = "diagnostics",
						focus = false,
						filter = {
							severity = vim.diagnostic.severity.ERROR,
						},
						win = {
							position = "right",
							size = 45,
						},
					})
				end,
				desc = "Project errors",
			},
			{ "<leader>qf", "<cmd>Trouble quickfix toggle focus=true<cr>", desc = "Quickfix" },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("trouble").setup({
				auto_preview = true,
				focus = false,
				keys = {
					["<cr>"] = "jump_close",
				},
				win = {
					position = "right",
					size = 45,
				},
			})
		end,
	},
}
