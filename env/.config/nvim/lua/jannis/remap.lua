vim.g.mapleader = " "
vim.keymap.set({ "n", "v" }, "<C-y>", '"+y', { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "i" }, "<C-a>", "<esc>gg_vG$", { noremap = true, silent = true })
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ bufnr = 0 })
end)

vim.keymap.set("n", "<leader>e", function()
	local diagnostics = require("jannis.diagnostics")

	vim.diagnostic.open_float(diagnostics.float_opts(0, {
		focus = false,
		focusable = false,
		scope = "line",
	}))
end, { desc = "Open diagnostics float" })
