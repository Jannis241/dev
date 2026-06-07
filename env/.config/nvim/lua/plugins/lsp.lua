return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"j-hui/fidget.nvim",
	},
	config = function()
		require("conform").setup()
		require("fidget").setup()
		require("mason").setup()

		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

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
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
            },
		})


        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_confirm = { behavior = cmp.ConfirmBehavior.Insert, select = true }



		cmp.setup({
            -- damit man nicht immer das erste noch auswählen muss, sondern direkt dort startet
            preselect = cmp.PreselectMode.Item,

			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-j>"] = cmp.mapping.select_next_item(cmp_select),

                ["<Tab>"] = cmp.mapping.confirm(cmp_confirm),
                ["<CR>"] = cmp.mapping.confirm(cmp_confirm),
			}),

            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
			}, {
				{ name = "buffer" },
			}),

			vim.diagnostic.config({
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			}),
		})
	end,
}
