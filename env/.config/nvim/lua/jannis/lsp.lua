local function map(bufnr, mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("jannis_lsp", { clear = true }),
    callback = function(event)
        local bufnr = event.buf

        map(bufnr, "n", "<leader>gd", vim.lsp.buf.definition, "Go to definition")
        map(bufnr, "n", "<leader>gb", "<C-o>", "Go back")
        map(bufnr, "n", "<leader>gf", "<C-i>", "Go forward")
        map(bufnr, "n", "K", function()
            vim.lsp.buf.hover({ border = "rounded" })
        end, "Hover")
        map(bufnr, "n", "<leader>rn", vim.lsp.buf.rename, "Rename")
        map(bufnr, { "i", "n" }, "<C-h>", vim.lsp.buf.signature_help, "Signature help")
    end,
})
