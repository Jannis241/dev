return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"j-hui/fidget.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		require("fidget").setup()
		require("mason").setup()

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		capabilities = vim.tbl_deep_extend("force", capabilities, {
			textDocument = {
				foldingRange = {
					dynamicRegistration = false,
					lineFoldingOnly = true,
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"jdtls",
				"clangd",
				"rust_analyzer",
				"gopls",
				"pyright",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
			},
		})

		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			severity_sort = true,
			float = {
				focusable = true,
				style = "minimal",
				-- border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
