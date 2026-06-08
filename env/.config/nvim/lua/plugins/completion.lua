return {
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = {
          "saghen/blink.lib",
		"rafamadriz/friendly-snippets",
	},
	build = function()
		require("blink.cmp").build():pwait()
	end,

	opts = {
		keymap = {
			preset = "default",
			["<C-j>"] = { "select_next" },
			["<C-k>"] = { "select_prev" },
			["<C-b>"] = { "scroll_documentation_up" },
			["<C-f>"] = { "scroll_documentation_down" },
			["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
			["<CR>"] = { "select_and_accept", "fallback" },
			["<tab>"] = { "select_and_accept", "fallback" },
			["<C-d>"] = { "show", "show_documentation", "hide_documentation" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},
		signature = { enabled = true },

		completion = {
			documentation = { auto_show = true },
			ghost_text = { enabled = true },
		},
		sources = { default = { "lsp", "path", "snippets", "buffer" } },
		fuzzy = { implementation = "rust" },
	},
}
