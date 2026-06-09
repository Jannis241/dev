return {
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	opts = {
		keymap = {
			preset = "default",
			["<C-j>"] = { "select_next" },
			["<C-k>"] = { "select_prev" },
			["<C-b>"] = { "scroll_documentation_up" },
			["<C-f>"] = { "scroll_documentation_down" },

			["<CR>"] = { "accept", "fallback" },
			["<tab>"] = { "accept", "fallback" },

			["<C-l>"] = { "snippet_forward", "fallback" },
			["<C-h>"] = { "snippet_backward", "fallback" },

			["<C-d>"] = { "show", "show_documentation", "hide_documentation" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},
		signature = { enabled = false },

		completion = {
			ghost_text = { enabled = true },
			documentation = {
				auto_show = false,
			},
			list = {
				selection = {
					preselect = true,
					auto_insert = false,
				},
			},
		},
		sources = { default = { "lsp", "path", "snippets", "buffer" } },
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
}
