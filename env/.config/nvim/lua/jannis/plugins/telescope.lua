return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.8",

	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		telescope.setup({
			pickers = {
				find_files = {
					hidden = true,
				},
			},
		})
		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		vim.keymap.set("n", "<leader>pws", builtin.current_buffer_fuzzy_find, {})
		vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

		vim.keymap.set("n", "<leader>pg", function()
			local search = vim.fn.input("Grep > ")
			local cmd = string.format("silent! grep %s **/*", vim.fn.shellescape(search))
			vim.cmd(cmd)
			vim.cmd("copen")
		end)

		vim.keymap.set("n", "<leader>pgs", function()
			local search = vim.fn.input("Grep (current buffer) > ")
			local current_file = vim.fn.expand("%:p") -- Vollständiger Pfad der aktuellen Datei
			local cmd =
				string.format("silent! grep %s %s", vim.fn.shellescape(search), vim.fn.shellescape(current_file))
			vim.cmd(cmd)
			vim.cmd("copen")
		end)
	end,
}
