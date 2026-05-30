return {
	"stevearc/conform.nvim",
	lazy = true,
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				java = { "google-java-format" },
				lua = { "stylua" },
				python = { "black" },
				rust = { "rustfmt" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				zsh = { "shfmt" },
			},
		})
	end,
}
