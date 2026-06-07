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
		local capabilities = require("jannis.lsp.capabilities").make()
		local diagnostics = require("jannis.diagnostics")

		local interactive = #vim.api.nvim_list_uis() > 0
		local jdtls_java_home = vim.env.JDTLS_JAVA_HOME ~= "" and vim.env.JDTLS_JAVA_HOME
			or vim.env.JAVA_HOME ~= "" and vim.env.JAVA_HOME
			or nil

		local function java_root(bufnr, on_dir)
			local name = vim.api.nvim_buf_get_name(bufnr)
			if name == "" then
				on_dir(vim.uv.cwd())
				return
			end

			local root = vim.fs.root(bufnr, {
				"mvnw",
				"gradlew",
				"settings.gradle",
				"settings.gradle.kts",
				"build.xml",
				"pom.xml",
				"build.gradle",
				"build.gradle.kts",
				".git",
			})

			on_dir(root or vim.fs.dirname(name))
		end

		require("fidget").setup()
		if interactive then
			require("mason").setup()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"black",
					"clang-format",
					"google-java-format",
					"jdtls",
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
				root_dir = java_root,
				workspace_required = false,
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

		if vim.lsp.enable then
			vim.lsp.enable(servers)
		end

		if interactive then
			require("mason-lspconfig").setup({
				-- Rust is handled by rustaceanvim. Do not let mason-lspconfig
				-- auto-enable a second rust_analyzer client.
				ensure_installed = servers,
				automatic_enable = false,
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
