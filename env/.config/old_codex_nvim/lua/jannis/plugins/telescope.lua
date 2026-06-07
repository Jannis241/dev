return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	keys = {
		{
			"<leader>pf",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Find files",
		},
		{
			"<leader>pws",
			function()
				require("telescope.builtin").current_buffer_fuzzy_find()
			end,
			desc = "Buffer fuzzy find",
		},
		{
			"<leader>ps",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Live grep",
		},
		{
			"<leader>fb",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fh",
			function()
				require("telescope.builtin").help_tags()
			end,
			desc = "Help tags",
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return require("jannis.requirements").can_build_native()
			end,
		},
		"nvim-telescope/telescope-ui-select.nvim",
	},

	config = function()
		-- Compatibility shim for older Telescope versions on newer Neovim APIs.
		if
			vim.treesitter
			and vim.treesitter.language
			and vim.treesitter.language.ft_to_lang == nil
			and vim.treesitter.language.get_lang
		then
			vim.treesitter.language.ft_to_lang = vim.treesitter.language.get_lang
		end

		local telescope = require("telescope")
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

		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")
	end,
}
