vim.g.mapleader = " "

-- ctrl y und ctrl a => windows imitieren
vim.keymap.set({ "n", "v" }, "<C-y>", '"+y', { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "i" }, "<C-a>", "<esc>gg_vG$", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>pv", ":Neotree<CR>")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- formatting
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ bufnr = 0 })
end)
