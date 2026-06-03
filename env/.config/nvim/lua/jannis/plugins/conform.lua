return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ bufnr = 0 }, function(err, did_edit)
					if err then
						vim.notify(err, vim.log.levels.WARN, { title = "Format" })
					elseif not did_edit then
						vim.notify("Buffer already formatted", vim.log.levels.INFO, { title = "Format" })
					end
				end)
			end,
			desc = "Format buffer",
		},
	},
	opts = {},
	config = function()
		local format_on_save_filetypes = {
			java = true,
			python = true,
			rust = true,
		}

		require("conform").setup({
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
			default_format_opts = {
				lsp_format = "fallback",
				timeout_ms = 3000,
			},
			format_on_save = function(bufnr)
				if not format_on_save_filetypes[vim.bo[bufnr].filetype] then
					return
				end

				return {
					async = false,
				}
			end,
		})
	end,
}
