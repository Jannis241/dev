vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	if vim.fn.executable("git") ~= 1 then
		error("lazy.nvim fehlt und git ist nicht installiert. Installiere git und starte Neovim erneut.")
	end

	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("jannis.set")
require("jannis.statusline").setup()
require("jannis.terminal").setup()

if vim.lsp and vim.lsp.get_buffers_by_client_id then
	vim.lsp.get_buffers_by_client_id = function(client_id)
		local client = vim.lsp.get_client_by_id(client_id)
		if not client then
			return {}
		end

		local buffers = {}
		for bufnr in pairs(client.attached_buffers or {}) do
			if vim.api.nvim_buf_is_valid(bufnr) then
				table.insert(buffers, bufnr)
			end
		end
		table.sort(buffers)
		return buffers
	end
end

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local g = augroup("jannis", {})

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

autocmd("BufWritePre", {
	group = g,
	pattern = "*",
	callback = function(args)
		local bufnr = args.buf
		if vim.bo[bufnr].buftype ~= "" or not vim.bo[bufnr].modifiable or vim.bo[bufnr].readonly then
			return
		end

		vim.cmd([[keepjumps keeppatterns silent! %s/\s\+$//e]])
	end,
})

autocmd("LspAttach", {
	group = g,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
		vim.keymap.set("n", "<leader>gb", "<C-o>", vim.tbl_extend("force", opts, { desc = "Go back" }))
		vim.keymap.set("n", "<leader>gf", "<C-i>", vim.tbl_extend("force", opts, { desc = "Go forward" }))
		vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
		vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
		vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>fr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "i", "n" }, "<C-h>", vim.lsp.buf.signature_help, opts)
	end,
})

vim.keymap.set("n", "<leader>e", function()
	local diagnostics = require("jannis.diagnostics")
	vim.diagnostic.open_float(diagnostics.float_opts(0, {
		focus = false,
		focusable = false,
		scope = "line",
	}))
end, { desc = "Open diagnostics float" })

vim.keymap.set("n", "<leader>fe", function()
	local diagnostics = require("jannis.diagnostics")
	vim.diagnostic.setloclist(diagnostics.filter({ open = true }, 0))
end, { desc = "File diagnostics" })

vim.keymap.set("n", "<leader>pe", function()
	local diagnostics = require("jannis.diagnostics")
	vim.diagnostic.setqflist(diagnostics.filter({ open = true }, 0))
end, { desc = "Project diagnostics" })

require("lazy").setup("jannis.plugins", {
	install = {
		missing = true,
	},
	checker = {
		enabled = false,
	},
	change_detection = {
		notify = false,
	},
})

require("jannis.theme").setup()
require("jannis.remap")
