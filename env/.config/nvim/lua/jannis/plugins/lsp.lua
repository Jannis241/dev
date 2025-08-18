local root_files = {
	".luarc.json",
	".luarc.jsonc",
	".luacheckrc",
	".stylua.toml",
	"stylua.toml",
	"selene.toml",
	"selene.yml",
	".git",
}

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
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt" },
				python = { "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				go = { "gofmt" },
			},
		})

		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("fidget").setup()
		require("mason").setup()

		-- mason update -> installiert alles
		-- wichtig dass man selber immer die dependencies runterläd.
		-- bsp: für c und c++: clang
		-- rust-analyzer mti rustup usw sollte man auch haben damit alles gut funktoiniert
		-- sonst gibt es einen error
		--
		--
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "jdtls",
    "pyright",
    "gopls",
    "clangd",
  },
  handlers = {
    function(server_name)
      if server_name == "rust_analyzer" then
        return
      end
      require("lspconfig")[server_name].setup({
        capabilities = capabilities,
      })
    end,
  },
})


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
					max_height = 10, -- max Zeilen
					max_width = 20, -- max Spalten
				}),
				documentation = cmp.config.window.bordered({
					max_height = 10,
					max_width = 20,
				}),
			},

			sources = cmp.config.sources({
				{ name = "copilot", group_index = 2 },
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
			},
			signs = true, -- links in der SignColumn
			underline = true, -- rote / gelbe Unterstreichungen
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
