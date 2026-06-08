return {
	"folke/trouble.nvim",
    	opts = {
		focus = true,
	},
	cmd = "Trouble",
	keys = {
		{ "<leader>tw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
		{
			"<leader>tb",
			"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
			desc = "Open trouble document diagnostics",
		},
	},
}
