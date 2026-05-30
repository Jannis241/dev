return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/nvim-cmp",
		{
			"onsails/lspkind.nvim",
			opts = {
				mode = "symbol_text",
				preset = "codicons",
			},
		},
		"j-hui/fidget.nvim",
	},

	config = function()
		local cmp_lsp = require("cmp_nvim_lsp")
		local diagnostics = require("jannis.diagnostics")
		local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

		if not vim.env.PATH:find(mason_bin, 1, true) then
			vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
		end

		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)
		capabilities.textDocument.completion.completionItem.snippetSupport = false

		local interactive = #vim.api.nvim_list_uis() > 0
		local jdtls_java_home = vim.env.JDTLS_JAVA_HOME

		require("fidget").setup()
		if interactive then
			require("mason").setup()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"black",
					"google-java-format",
					"rust-analyzer",
					"shellcheck",
					"shfmt",
					"stylua",
				},
				auto_update = false,
				run_on_start = true,
				start_delay = 3000,
			})
		end

		local servers = {
			"lua_ls",
			"jdtls",
			"pyright",
			"gopls",
			"clangd",
		}

		local server_configs = {
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Disable",
						},
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			},
			jdtls = {
				cmd_env = jdtls_java_home and jdtls_java_home ~= "" and {
					JAVA_HOME = jdtls_java_home,
				} or nil,
				root_markers = {
					{ "mvnw", "gradlew", "settings.gradle", "settings.gradle.kts", ".git" },
					{ "build.xml", "pom.xml", "build.gradle", "build.gradle.kts" },
					"src",
				},
			},
			clangd = {
				init_options = {
					fallbackFlags = { "-x", "c", "-std=c17" },
				},
			},
		}

		if vim.lsp.config then
			for _, server_name in ipairs(servers) do
				vim.lsp.config(
					server_name,
					vim.tbl_deep_extend("force", {
						capabilities = capabilities,
					}, server_configs[server_name] or {})
				)
			end
		end

		if interactive then
			require("mason-lspconfig").setup({
				-- Rust is handled by rustaceanvim. Do not let mason-lspconfig
				-- auto-enable a second rust_analyzer client.
				ensure_installed = servers,
				automatic_enable = {
					exclude = {
						"rust_analyzer",
					},
				},
			})
		end

		require("jannis.lsp.completion").setup()

		local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.diagnostic.config({
			virtual_text = diagnostics.virtual_text,
			signs = diagnostics.signs,
			underline = diagnostics.underline,

			update_in_insert = false,
			severity_sort = true,
			float = diagnostics.float,
		})
	end,
}
