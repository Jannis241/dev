return {
	"mrcjkb/rustaceanvim",
	version = "^6",
	ft = { "rust" },
	init = function()
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			require("rustaceanvim.config.server").create_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)
		capabilities.textDocument.completion.completionItem.snippetSupport = false

		local function has_rust_project(root)
			return root
				and (
					vim.uv.fs_stat(root .. "/Cargo.toml") ~= nil
					or vim.uv.fs_stat(root .. "/rust-project.json") ~= nil
				)
		end

		local function rust_analyzer_settings(project_root)
			local standalone = not has_rust_project(project_root)
			local standalone_file = vim.api.nvim_buf_get_name(0)

			return {
				["rust-analyzer"] = {
					checkOnSave = not standalone,
					check = {
						command = "check",
						enable = not standalone,
					},
					cachePriming = {
						enable = not standalone,
					},
					cargo = {
						allTargets = not standalone,
						noDeps = standalone,
						buildScripts = {
							enable = not standalone,
						},
					},
					linkedProjects = standalone and { standalone_file } or nil,
					procMacro = {
						enable = not standalone,
					},
					inlayHints = {
						lifetimeElisionHints = { enable = true, useParameterNames = true },
						parameterHints = true,
						typeHints = true,
						chainingHints = true,
					},
				},
			}
		end

		vim.g.rustaceanvim = {
			server = {
				capabilities = capabilities,
				settings = rust_analyzer_settings,
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
