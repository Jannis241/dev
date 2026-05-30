vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>pv", "<cmd>Oil<CR>", { desc = "Open file browser" })

vim.keymap.set("n", "<leader>q", function()
	pcall(vim.cmd.cclose)
	pcall(vim.cmd.lclose)
end, { desc = "Close quickfix/location list" })

vim.keymap.set({ "n", "v" }, "<C-y>", '"+y', { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "i" }, "<C-a>", "<esc>gg_vG$", { noremap = true, silent = true })

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ bufnr = 0, lsp_format = "fallback", timeout_ms = 3000 })
end, { desc = "Format buffer" })

vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("source %")
end, { desc = "Source current file" })
