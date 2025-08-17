local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>tt", "<cmd>Trouble toggle<cr>", {})


vim.keymap.set("n", "<leader>td", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Workspace)" })
vim.keymap.set("n", "<leader>tb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Diagnostics (Buffer)" })
-- vim.keymap.set("n", "<leader>fr", "<cmd>Trouble lsp_references toggle<cr>", { desc = "LSP References" })
vim.keymap.set("n", "<leader>qf", "<cmd>Trouble quickfix toggle<cr>", { desc = "Quickfix" })

-- Springt zum vorherigen Fehler, egal in welcher Datei
vim.keymap.set("n", "<C-k>", function()
    require("trouble").previous({ skip_groups = true, jump = true })
end, { noremap = true, silent = true })

-- Springt zum nächsten Fehler, egal in welcher Datei
vim.keymap.set("n", "<C-j>", function()
    require("trouble").next({ skip_groups = true, jump = true })
end, { noremap = true, silent = true })

vim.keymap.set(
	"n",
	"K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
	function()
		vim.cmd.RustLsp({ "hover", "actions" })
	end,
	{ silent = true, buffer = bufnr }
)
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>e", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
-- 	function()
--         vim.cmd.RustLsp('explainError')
-- 	end,
-- 	{ silent = true, buffer = bufnr }
-- )
vim.keymap.set(
	"n",
	"<leader>rd", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
	function()
        vim.cmd.RustLsp('renderDiagnostic')
	end,
	{ silent = true, buffer = bufnr }
)
vim.keymap.set(
	"n",
	"<leader>od", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
	function()
        vim.cmd.RustLsp('openDocs')
	end,
	{ silent = true, buffer = bufnr }
)

vim.g.mapleader = " "

vim.cmd([[nnoremap \ :Neotree reveal<cr>]])

vim.keymap.set("n", "q", ":cclose<CR>", {})

-- ctrl y zum kopieren (ctrl - c wird vom terminal abgefangen)
vim.keymap.set({ "n", "v" }, "<C-y>", '"+y', { noremap = true, silent = true })

-- ctrl a um alles zu selecten
vim.keymap.set({ "n", "v", "i" }, "<C-a>", "<esc>gg_vG$", { noremap = true, silent = true })

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
