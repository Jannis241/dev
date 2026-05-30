local uv = vim.uv or vim.loop
local max_treesitter_filesize = 1024 * 1024
local max_treesitter_lines = 10000

local function is_large_buffer(bufnr)
	if vim.api.nvim_buf_line_count(bufnr) > max_treesitter_lines then
		return true
	end

	local name = vim.api.nvim_buf_get_name(bufnr)
	if name == "" then
		return false
	end

	local ok, stat = pcall(uv.fs_stat, name)
	return ok and stat and stat.size > max_treesitter_filesize
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			local ts = require("nvim-treesitter")
			local ts_config = require("nvim-treesitter.config")
			local parsers = require("nvim-treesitter.parsers")

			ts.setup({})

			parsers.templ = {
				install_info = {
					url = "https://github.com/vrischmann/tree-sitter-templ.git",
					files = { "src/parser.c", "src/scanner.c" },
					branch = "master",
				},
			}

			vim.treesitter.language.register("templ", "templ")

			local ensure_installed = {
				"vimdoc",
				"c",
				"lua",
				"rust",
				"python",
				"bash",
				"go",
				"java",
				"cpp",
				"templ",
			}

			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					local missing = ts_config.norm_languages(ensure_installed, { installed = true })

					if #missing > 0 then
						ts.install(missing)
					end
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function(args)
					if is_large_buffer(args.buf) then
						return
					end

					local ft = vim.bo[args.buf].filetype
					local lang = vim.treesitter.language.get_lang(ft)
					if not lang then
						return
					end

					pcall(vim.treesitter.start, args.buf, lang)
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
