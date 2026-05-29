return {
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{
				"<leader>fe",
				function()
					local diagnostics = require("jannis.diagnostics")

					require("trouble").open({
						mode = "diagnostics",
						focus = true,
						pinned = true,
						filter = diagnostics.filter({
							buf = 0,
						}, 0),
						win = {
							position = "right",
							size = 45,
						},
					})
				end,
				desc = "File diagnostics",
			},
			{
				"<leader>pe",
				function()
					local diagnostics = require("jannis.diagnostics")

					require("trouble").open({
						mode = "diagnostics",
						focus = true,
						filter = diagnostics.filter({}, 0),
						win = {
							position = "right",
							size = 45,
						},
					})
				end,
				desc = "Project diagnostics",
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
