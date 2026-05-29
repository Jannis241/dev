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
		local jdtls_java_home = vim.env.JDTLS_JAVA_HOME

		require("fidget").setup()
		if interactive then
			require("mason").setup()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"black",
					"google-java-format",
					"prettier",
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
							callSnippet = "Replace",
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

		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		local lspkind = require("lspkind")
		local cmp_border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
		local function completion_widths()
			return {
				abbr = math.max(16, math.min(42, math.floor(vim.o.columns * 0.26))),
				menu = math.max(8, math.min(24, math.floor(vim.o.columns * 0.14))),
			}
		end
		local function doc_width()
			return math.max(24, math.min(70, math.floor(vim.o.columns * 0.40)))
		end
		local function doc_height()
			return math.max(8, math.min(18, math.floor(vim.o.lines * 0.35)))
		end
		local function bordered_window(opts, extra)
			return vim.tbl_extend("force", cmp.config.window.bordered(opts), extra or {})
		end

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			view = {
				entries = {
					name = "custom",
					selection_order = "top_down",
					vertical_positioning = "below",
					follow_cursor = false,
				},
				docs = {
					auto_open = true,
				},
			},
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text", -- show only symbol annotations
					maxwidth = {
						-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						-- can also be a function to dynamically calculate max width such as
						-- menu = function() return math.floor(0.45 * vim.o.columns) end,
						menu = function()
							return completion_widths().menu
						end, -- leading text (labelDetails)
						abbr = function()
							return completion_widths().abbr
						end, -- actual suggestion item
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
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
			}),
			window = {
				completion = bordered_window({
					border = cmp_border,
					max_height = 12,
					side_padding = 1,
					scrollbar = false,
					winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None",
					zindex = 1002,
				}),
				documentation = bordered_window({
					border = cmp_border,
					max_height = doc_height(),
					side_padding = 1,
					scrollbar = false,
					winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocBorder",
					zindex = 1001,
				}, {
					max_width = doc_width(),
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
			virtual_text = diagnostics.virtual_text,
			signs = diagnostics.signs,
			underline = diagnostics.underline,

			update_in_insert = false, -- nach :w oder wenn du Insert verlässt
			severity_sort = true, -- sortiert nach Error > Warn > Hint > Info
			float = diagnostics.float,
		})
	end,
}
