return {
    "nvim-telescope/telescope.nvim",
    version = '*',
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },

    config = function ()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        telescope.setup({
			defaults = {
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
			},
		})

        -- für schönes highlighting in der preview ansicht
        local preview_utils = require("telescope.previewers.utils")
        preview_utils.ts_highlighter = function(bufnr, ft)
            if not ft or ft == "" then
                return false
            end

            local lang = vim.treesitter.language.get_lang(ft) or ft
            if not lang or lang == "" then
                return false
            end

            return pcall(vim.treesitter.start, bufnr, lang)
        end

        local builtin = require("telescope.builtin")

        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<leader>pws', builtin.current_buffer_fuzzy_find, {})
        vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set("n", "<leader>pg", builtin.grep_string, {})
    end
}
