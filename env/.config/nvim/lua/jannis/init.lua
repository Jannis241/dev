vim.g.mapleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("jannis.set")

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

function R(name)
	require("plenary.reload").reload_module(name)
end

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

autocmd({ "BufWritePre" }, {
	group = g,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd("LspAttach", {
	group = g,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "<leader>gd", function()
			vim.lsp.buf.definition()
		end, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
		vim.keymap.set("n", "<leader>gb", "<C-o>", vim.tbl_extend("force", opts, { desc = "Go back" }))
		vim.keymap.set("n", "<leader>gf", "<C-i>", vim.tbl_extend("force", opts, { desc = "Go forward" }))
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, opts)
		vim.keymap.set("n", "<C-k>", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>e", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>fr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>rn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_prev()
		end, opts)
		vim.keymap.set("n", "<leader>ne", function()
			vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
		end, vim.tbl_extend("force", opts, { desc = "Next error" }))
		vim.keymap.set("n", "<leader>pe", function()
			vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
		end, vim.tbl_extend("force", opts, { desc = "Previous error" }))
		vim.keymap.set({ "i", "n" }, "<C-h>", vim.lsp.buf.signature_help, {})
	end,
})

require("lazy").setup("jannis.plugins")
require("jannis.theme").setup()

require("jannis.remap")
