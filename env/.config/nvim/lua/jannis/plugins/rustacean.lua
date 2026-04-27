return {
	"mrcjkb/rustaceanvim",
	version = "^6",
	lazy = false,
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "rust",
			callback = function(ev)
				local opts = { silent = true, buffer = ev.buf }
				vim.keymap.set("n", "<leader>ra", function()
					vim.cmd.RustLsp({ "hover", "actions" })
				end, opts)
				vim.keymap.set("n", "<leader>rd", function()
					vim.cmd.RustLsp("renderDiagnostic")
				end, opts)
				vim.keymap.set("n", "<leader>od", function()
					vim.cmd.RustLsp("openDocs")
				end, opts)
			end,
		})
	end,
}
