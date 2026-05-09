return {
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{
				"<leader>ef",
				function()
					require("trouble").toggle({
						mode = "diagnostics",
						focus = true,
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
				"<leader>ep",
				function()
					require("trouble").toggle({
						mode = "diagnostics",
						focus = true,
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
				focus = true,
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
