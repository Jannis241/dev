return {
	{
		"toppair/peek.nvim",
		cmd = { "PeekOpen", "PeekClose" },
		ft = { "markdown" },
		build = function()
			if vim.fn.executable("deno") == 1 then
				vim.fn.system({ "deno", "task", "--quiet", "build:fast" })
			end
		end,
		config = function()
			require("peek").setup({
				filetype = { "markdown" },
			})
			vim.api.nvim_create_user_command("PeekOpen", function()
				if vim.fn.executable("deno") ~= 1 then
					vim.notify(
						"Peek braucht deno. Installiere deno oder nutze Markdown ohne Preview.",
						vim.log.levels.WARN
					)
					return
				end
				require("peek").open()
			end, {})
			vim.api.nvim_create_user_command("PeekClose", function()
				require("peek").close()
			end, {})
		end,
	},
}
