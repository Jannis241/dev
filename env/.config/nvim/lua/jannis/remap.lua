vim.g.mapleader = " "

vim.keymap.set("n", "<leader>e", function()
  local diags = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
  if #diags > 0 then
    vim.diagnostic.open_float(nil, { focusable = false, border = "rounded" })
  else
    vim.lsp.buf.hover()
  end
end, { desc = "Show diagnostics or hover" })
vim.cmd([[nnoremap \ :Neotree reveal<cr>]])


 vim.keymap.set("n", "<leader>h", vim.lsp.buf.signature_help, {})
 vim.keymap.set("n", "q", ":cclose<CR>", {})

-- ctrl y zum kopieren (ctrl - c wird vom terminal abgefangen)
vim.keymap.set({'n', 'v'}, "<C-y>", '"+y', { noremap = true, silent = true })

-- ctrl a um alles zu selecten
vim.keymap.set({'n', 'v', 'i'}, "<C-a>", '<esc>gg_vG$', { noremap = true, silent = true })



vim.keymap.set("n", "<leader>ppv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pv", ":Neotree<CR>")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ bufnr = 0 })
end)

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)
