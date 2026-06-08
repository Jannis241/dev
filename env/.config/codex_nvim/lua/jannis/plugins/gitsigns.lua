return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		current_line_blame = false,
		current_line_blame_opts = {
			delay = 300,
			virt_text_pos = "eol",
		},
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")
			local opts = { buffer = bufnr }

			vim.keymap.set("n", "]h", gitsigns.next_hunk, vim.tbl_extend("force", opts, { desc = "Next git hunk" }))
			vim.keymap.set("n", "[h", gitsigns.prev_hunk, vim.tbl_extend("force", opts, { desc = "Previous git hunk" }))
			vim.keymap.set(
				"n",
				"<leader>hs",
				gitsigns.stage_hunk,
				vim.tbl_extend("force", opts, { desc = "Stage hunk" })
			)
			vim.keymap.set(
				"n",
				"<leader>hr",
				gitsigns.reset_hunk,
				vim.tbl_extend("force", opts, { desc = "Reset hunk" })
			)
			vim.keymap.set("v", "<leader>hs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, vim.tbl_extend("force", opts, { desc = "Stage hunk" }))
			vim.keymap.set("v", "<leader>hr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, vim.tbl_extend("force", opts, { desc = "Reset hunk" }))
			vim.keymap.set(
				"n",
				"<leader>hp",
				gitsigns.preview_hunk,
				vim.tbl_extend("force", opts, { desc = "Preview hunk" })
			)
			vim.keymap.set(
				"n",
				"<leader>hb",
				gitsigns.blame_line,
				vim.tbl_extend("force", opts, { desc = "Blame line" })
			)
			vim.keymap.set(
				"n",
				"<leader>hB",
				gitsigns.toggle_current_line_blame,
				vim.tbl_extend("force", opts, { desc = "Toggle line blame" })
			)
			vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, vim.tbl_extend("force", opts, { desc = "Diff this" }))
		end,
	},
}
