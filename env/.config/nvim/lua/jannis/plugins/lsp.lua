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
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
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
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		local interactive = #vim.api.nvim_list_uis() > 0

		require("fidget").setup()
		if interactive then
			require("mason").setup()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"black",
					"google-java-format",
					"prettier",
					"rust-analyzer",
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
			jdtls = {
				root_markers = {
					{ "mvnw", "gradlew", "settings.gradle", "settings.gradle.kts", ".git" },
					{ "build.xml", "pom.xml", "build.gradle", "build.gradle.kts" },
					"src",
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

		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		local lspkind = require("lspkind")

		cmp.setup({
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text", -- show only symbol annotations
					maxwidth = {
						-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						-- can also be a function to dynamically calculate max width such as
						-- menu = function() return math.floor(0.45 * vim.o.columns) end,
						menu = 50, -- leading text (labelDetails)
						abbr = 50, -- actual suggestion item
					},
					ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					show_labelDetails = true, -- show labelDetails in menu. Disabled by default

					-- The function below will be called before any actual modifications from lspkind
					-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
					before = function(entry, vim_item)
						-- ...
						return vim_item
					end,
				}),
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
				["<tab>"] = cmp.mapping.confirm({ select = true }),
				["<enter>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			window = {
				completion = cmp.config.window.bordered({
					max_height = 12, -- max Zeilen
					max_width = 60, -- max Spalten
					winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
				}),
				documentation = cmp.config.window.bordered({
					max_height = 14,
					max_width = 80,
					winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
				}),
			},

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

		local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Diagnostic Config
		vim.diagnostic.config({
			virtual_text = {
				prefix = "", -- kleines Icon statt nur Text
				spacing = 2, -- Abstand zum Text
				severity = vim.diagnostic.severity.ERROR, -- nur Errors anzeigen
			},
			signs = {
				severity = vim.diagnostic.severity.ERROR, -- nur Errors anzeigen
			},
			underline = {
				severity = vim.diagnostic.severity.ERROR, -- nur Errors anzeigen
			},

			update_in_insert = false, -- nach :w oder wenn du Insert verlässt
			severity_sort = true, -- sortiert nach Error > Warn > Hint > Info
			float = {
				focusable = true,
				border = "rounded", -- schöne runde Ränder
				source = "if_many", -- Quelle nur anzeigen, wenn mehrere
				header = "",
				prefix = "",
			},
		})
	end,
}
