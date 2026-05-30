return {
	"mrcjkb/rustaceanvim",
	version = "^6",
	ft = { "rust" },
	init = function()
		vim.g.rustaceanvim = {
			server = {
				settings = {
					["rust-analyzer"] = {
						checkOnSave = true,
						inlayHints = {
							lifetimeElisionHints = { enable = true, useParameterNames = true },
							parameterHints = true,
							typeHints = true,
							chainingHints = true,
						},
					},
				},
			},
			dap = {},
			tools = {},
		}
	end,
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "rust",
			callback = function(ev)
				local opts = { silent = true, buffer = ev.buf }
				vim.keymap.set("n", "<leader>ra", function()
					vim.cmd.RustLsp({ "hover", "actions" })
				end, opts)
				vim.keymap.set("n", "<leader>rd", function()
					vim.cmd.RustLsp("renderDiagnostic")
				end, opts)
				vim.keymap.set("n", "<leader>od", function()
					vim.cmd.RustLsp("openDocs")
				end, opts)
			end,
		})
	end,
}
