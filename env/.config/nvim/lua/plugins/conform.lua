return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			format_on_save = false,
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				go = { "gofmt" },
				java = { "google-java-format" },
				lua = { "stylua" },
				python = { "black" },
				rust = { "rustfmt" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				zsh = { "shfmt" },
			},
			formatters = {
				["clang-format"] = {
					prepend_args = {
						"--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never}",
					},
				},
			},
		})

		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ bufnr = 0 })
		end)
	end,
}
