return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	opts = {},
	config = function()
		local format_on_save_filetypes = {
			java = true,
			python = true,
			rust = true,
		}

		require("conform").setup({
			formatters_by_ft = {
				go = { "gofmt" },
				java = { "google-java-format" },
				javascript = { "prettier" },
				lua = { "stylua" },
				python = { "black" },
				rust = { "rustfmt" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				zsh = { "shfmt" },
				typescript = { "prettier" },
			},
			format_on_save = function(bufnr)
				if not format_on_save_filetypes[vim.bo[bufnr].filetype] then
					return
				end

				return {
					async = false,
					lsp_format = "fallback",
					timeout_ms = 3000,
				}
			end,
		})
	end,
}
