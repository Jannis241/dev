return {
	"tpope/vim-fugitive",
	cmd = { "Git", "G" },
	keys = {
		{ "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
		{ "gu", "<cmd>diffget //2<cr>", desc = "Diffget left" },
		{ "gh", "<cmd>diffget //3<cr>", desc = "Diffget right" },
	},
}
