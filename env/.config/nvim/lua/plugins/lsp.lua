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
					lineFoldingOnly = false,
				},
			},
		})

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		local clangd_capabilities = vim.tbl_deep_extend("force", {}, capabilities, {
			textDocument = {
				completion = {
					editsNearCursor = true,
				},
			},
			offsetEncoding = { "utf-8", "utf-16" },
		})

		local clangd_root_markers = {
			".clangd",
			".clang-tidy",
			".clang-format",
			"compile_commands.json",
			"compile_flags.txt",
			"configure.ac",
			".git",
		}

		local function clangd_on_init(client, init_result)
			if init_result.offsetEncoding then
				client.offset_encoding = init_result.offsetEncoding
			end
		end

		vim.lsp.config("clangd", {
			capabilities = clangd_capabilities,
			filetypes = { "cpp", "objc", "objcpp", "cuda" },
		})

		vim.lsp.config("clangd_c", {
			cmd = { "clangd" },
			capabilities = clangd_capabilities,
			filetypes = { "c" },
			root_markers = clangd_root_markers,
			get_language_id = function(_, filetype)
				return filetype
			end,
			init_options = {
				fallbackFlags = { "-x", "c" },
			},
			on_init = clangd_on_init,
		})
		vim.lsp.enable("clangd_c")

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"jdtls",
				"clangd",
				"rust_analyzer",
				"gopls",
				"pyright",
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
