return {
	{
		"stevearc/oil.nvim",
		lazy = false,
		dependencies = {
			"refractalize/oil-git-status.nvim",
		},
		config = function()
			require("oil").setup({
				default_file_explorer = true,
				columns = {},
				win_options = {
					wrap = false,
					signcolumn = "yes:2",
					cursorcolumn = false,
					foldcolumn = "0",
					spell = false,
					list = false,
					conceallevel = 3,
					concealcursor = "nvic",
				},
				delete_to_trash = false,
				skip_confirm_for_simple_edits = false,
				watch_for_changes = false,
				view_options = {
					show_hidden = true,
					natural_order = "fast",
					sort = {
						{ "type", "asc" },
						{ "name", "asc" },
					},
				},
				keymaps = {
					["<C-p>"] = false,
					["<C-t>"] = false,
					["<C-s>"] = false,
					["<C-h>"] = false,
				},
			})

			require("oil-git-status").setup({
				show_ignored = false,
			})
		end,
	},
}
