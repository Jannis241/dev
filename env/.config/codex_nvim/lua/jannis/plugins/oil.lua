return {
	"stevearc/oil.nvim",
	lazy = false,
	keys = {
		{
			"-",
			function()
				require("oil").open()
			end,
			desc = "Open parent directory",
		},
		{
			"<leader>pv",
			function()
				require("oil").open(vim.uv.cwd())
			end,
			desc = "Open project directory",
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
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
			-- ["l"] = "actions.select",
			-- ["<C-v>"] = { "actions.select", opts = { vertical = true } },
			-- ["<C-x>"] = { "actions.select", opts = { horizontal = true } },
			-- ["<C-t>"] = { "actions.select", opts = { tab = true } },
			["<C-p>"] = "actions.preview",
			-- ["<C-j>"] = "actions.preview_scroll_down",
			-- ["<C-k>"] = "actions.preview_scroll_up",
			["q"] = "actions.close",
			-- ["<esc>"] = "actions.close",
			-- ["h"] = "actions.parent",
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["`"] = "actions.cd",
			["cd"] = { "actions.cd", opts = { scope = "tab" } },
			["R"] = "actions.refresh",
			-- ["gs"] = "actions.change_sort",
			-- ["gx"] = "actions.open_external",
			["g."] = "actions.toggle_hidden",
			["g\\"] = "actions.toggle_trash",
			["gy"] = "actions.yank_entry", -- absoluter pfad der datei kopieren
			["gr"] = { "actions.yank_entry", opts = { modify = ":." } }, -- relativer pfad
			["y"] = "actions.copy_to_system_clipboard",
			["p"] = "actions.paste_from_system_clipboard",
			["P"] = { "actions.paste_from_system_clipboard", opts = { delete_original = true } },
			["!"] = "actions.open_terminal",
		},
	},
}
