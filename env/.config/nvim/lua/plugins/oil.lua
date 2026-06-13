return {
	"stevearc/oil.nvim",
	lazy = false,
	keys = {
		{
			"-",
			function()
				require("oil").open()
			end,
		},
		{
			"<leader>pv",
			function()
				require("oil").open(vim.uv.cwd())
			end,
		},
	},
	opts = {
		default_file_explorer = true,
		delete_to_trash = true,
		skip_confirm_for_simple_edits = false,
		watch_for_changes = true,
		columns = {
			"icon",
		},
		view_options = {
			show_hidden = true,
		},
		use_default_keymaps = false,
		keymaps = {
			["g?"] = "actions.show_help",
			["<cr>"] = "actions.select",
			["<C-p>"] = "actions.preview",
			["q"] = "actions.close",
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["R"] = "actions.refresh",
			["g."] = "actions.toggle_hidden",
			["gy"] = "actions.yank_entry", -- absoluter pfad der datei kopieren
			["gr"] = { "actions.yank_entry", opts = { modify = ":." } }, -- relativer pfad
			["y"] = "actions.copy_to_system_clipboard",
			["p"] = "actions.paste_from_system_clipboard",
			["P"] = { "actions.paste_from_system_clipboard", opts = { delete_original = true } },
		},
	},
}
