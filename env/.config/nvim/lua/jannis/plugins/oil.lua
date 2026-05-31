return {
	"stevearc/oil.nvim",
	cmd = "Oil",
	keys = {
		{
			"-",
			function()
				require("oil").open()
			end,
			desc = "Open parent directory",
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		default_file_explorer = true,
		delete_to_trash = false,
		skip_confirm_for_simple_edits = false,
		watch_for_changes = true,
		view_options = {
			show_hidden = true,
		},
		keymaps = {
			["<C-h>"] = false,
			["<C-l>"] = false,
			["q"] = "actions.close",
			["<esc>"] = "actions.close",
			["-"] = "actions.parent",
			["<cr>"] = "actions.select",
			["<C-v>"] = "actions.select_vsplit",
			["<C-s>"] = "actions.select_split",
			["<C-p>"] = "actions.preview",
			["g?"] = "actions.show_help",
		},
	},
}
