return {
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{
				"<leader>fe",
				function()
					require("trouble").open({
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
				"<leader>pe",
				function()
					require("trouble").open({
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
					j = "next",
					k = "prev",
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
