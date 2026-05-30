local function jdtls_cmd(dispatchers, config)
	local java_home = "/usr/lib/jvm/java-21-openjdk"
	local cache = vim.fn.stdpath("cache") .. "/jdtls"
	local root = config.root_dir or vim.fn.getcwd()
	local project = vim.fn.fnamemodify(root:gsub("/$", ""), ":t")
	if project == "" then
		project = "workspace"
	end
	local config_dir = cache .. "/config"
	local data_dir = cache .. "/workspace/" .. project

	vim.fn.mkdir(config_dir, "p")
	vim.fn.mkdir(data_dir, "p")

	return vim.lsp.rpc.start({
		"jdtls",
		"--java-executable",
		java_home .. "/bin/java",
		"-configuration",
		config_dir,
		"-data",
		data_dir,
	}, dispatchers, {
		cwd = config.cmd_cwd,
		env = vim.tbl_extend("force", config.cmd_env or {}, {
			JAVA_HOME = java_home,
		}),
		detached = config.detached,
	})
end

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
	},

	config = function()
		local cmp = require("cmp")
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

		local interactive = #vim.api.nvim_list_uis() > 0
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
			"clangd",
		}

		local server_configs = {
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			},
			jdtls = {
				cmd = jdtls_cmd,
				cmd_env = {
					JAVA_HOME = "/usr/lib/jvm/java-21-openjdk",
				},
				root_markers = {
					{ "mvnw", "gradlew", "settings.gradle", "settings.gradle.kts", ".git" },
					{ "build.xml", "pom.xml", "build.gradle", "build.gradle.kts" },
					"src",
				},
				settings = {
					java = {
						configuration = {
							runtimes = {
								{
									name = "JavaSE-21",
									path = "/usr/lib/jvm/java-21-openjdk",
									default = true,
								},
							},
						},
					},
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
				ensure_installed = servers,
				automatic_enable = {
					exclude = {
						"rust_analyzer",
					},
				},
			})
		end

		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},
			view = {
				docs = {
					auto_open = false,
				},
			},
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-f>"] = function(fallback)
					if cmp.visible_docs() then
						cmp.scroll_docs(4)
					elseif cmp.visible() then
						cmp.open_docs()
					else
						fallback()
					end
				end,
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
			}),
			window = {
				documentation = cmp.config.window.bordered({
					border = "single",
					max_height = 14,
					max_width = 72,
				}),
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
			}, {
				{ name = "buffer" },
			}),
		})

		for type, sign in pairs({ Error = "E", Warn = "W", Hint = "H", Info = "I" }) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = sign, texthl = hl, numhl = "" })
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
