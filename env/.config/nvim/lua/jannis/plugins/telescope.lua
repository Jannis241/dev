return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-ui-select.nvim",
	},

	config = function()
		-- Compatibility shim for older Telescope versions on newer Neovim APIs.
		if vim.treesitter
			and vim.treesitter.language
			and vim.treesitter.language.ft_to_lang == nil
			and vim.treesitter.language.get_lang
		then
			vim.treesitter.language.ft_to_lang = vim.treesitter.language.get_lang
		end

		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				prompt_prefix = "   ",
	 			selection_caret = " ",
				entry_prefix = " ",
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = { prompt_position = "top", preview_width = 0.55 },
					width = 0.87,
					height = 0.80,
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
					n = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["q"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					-- theme = "dropdown",
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- Fuzzy Match
					override_generic_sorter = true, -- ersetzt sorter
					override_file_sorter = true,
					case_mode = "smart_case", -- smart case
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}), -- nicer dropdown
				},
			},
		})

		-- Extensions laden
		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")

		-- Keymaps
		vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>pws", builtin.current_buffer_fuzzy_find, { desc = "Buffer fuzzy find" })
		vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
	end,
}
