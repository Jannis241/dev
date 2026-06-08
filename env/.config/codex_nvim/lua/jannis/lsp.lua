local function map(bufnr, mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("jannis_lsp", { clear = true }),
	callback = function(event)
		local ui = require("jannis.lsp.ui")
		local bufnr = event.buf

		map(bufnr, "n", "<leader>gr", vim.lsp.buf.references)
		map(bufnr, "n", "<leader>gd", vim.lsp.buf.definition, "Go to definition")
		map(bufnr, "n", "<leader>gb", "<C-o>", "Go back")
		map(bufnr, "n", "<leader>gf", "<C-i>", "Go forward")
		map(bufnr, "n", "K", function()
			vim.lsp.buf.hover(ui.lsp_float_config("hover"))
		end, "Hover")
		map(bufnr, "n", "<leader>rn", vim.lsp.buf.rename, "Rename")
		map(bufnr, { "i", "n" }, "<C-h>", function()
			vim.lsp.buf.signature_help(ui.lsp_float_config("signature"))
		end, "Signature help")
	end,
})
