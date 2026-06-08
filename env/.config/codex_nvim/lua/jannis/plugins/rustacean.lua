return {
	"mrcjkb/rustaceanvim",
	version = "^6",
	ft = { "rust" },
	init = function()
		local capabilities =
			require("jannis.lsp.capabilities").make(require("rustaceanvim.config.server").create_client_capabilities())

		local function read_cmd(args)
			local result = vim.fn.system(args)
			if vim.v.shell_error == 0 then
				return vim.trim(result)
			end
			return nil
		end

		local function standalone_project_path(file)
			local dir = vim.fn.stdpath("state") .. "/rust-standalone/" .. vim.fn.sha256(file)
			vim.fn.mkdir(dir, "p")

			return dir .. "/rust-project.json"
		end

		local function standalone_project(file)
			if file == "" then
				return nil
			end

			local project = {
				crates = {
					{
						root_module = file,
						edition = "2021",
						deps = {},
						cfg = {},
						env = vim.empty_dict(),
						is_workspace_member = true,
					},
				},
			}

			local sysroot = read_cmd({ "rustc", "--print", "sysroot" })
			if sysroot and sysroot ~= "" then
				local sysroot_src = sysroot .. "/lib/rustlib/src/rust/library"
				if vim.uv.fs_stat(sysroot_src) then
					project.sysroot_src = sysroot_src
				end
			end

			local path = standalone_project_path(file)
			local ok = pcall(vim.fn.writefile, { vim.json.encode(project) }, path)
			if ok then
				return path
			end
			return nil
		end

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
			local linked_projects = nil

			if standalone then
				local project = standalone_project(standalone_file)
				if project then
					linked_projects = { project }
				end
			end

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
					linkedProjects = linked_projects,
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
