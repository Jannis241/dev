return {
	"folke/trouble.nvim",
	opts = {
		focus = true,
        auto_close = true,
        indent_guides = true,

	},
	cmd = "Trouble",
	keys = {
		{ "<leader>tw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
		{ "<leader>f", "<cmd>Trouble diagnostics focus<CR>", desc = "Refocus trouble worksapce diagnostics" },
		{
			"<leader>tb",
			"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
			desc = "Open trouble document diagnostics",
		},
	},
}
