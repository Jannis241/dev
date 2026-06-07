return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			local parsers = {
				"lua",
				"vim",
				"html",
				"css",
				"json",
				"gitignore",
				"go",
                "bash",
                "cpp",
                "java",
                "python",
                "c",
                "rust",
			}

			local group = vim.api.nvim_create_augroup("TreesitterGroup", { clear = true })

            -- Nach dem Start von nvim alle fehlenden parser installieren
			vim.api.nvim_create_autocmd("User", {
				group = group,
				pattern = "VeryLazy",
				once = true,
				callback = function()
					require("nvim-treesitter").install(parsers)
				end,
			})

            -- Wenn ein buffer geöffnet wird, treesitter starten
			vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
				group = group,
				callback = function()
					if vim.bo.buftype ~= "" then
						return
					end

					pcall(vim.treesitter.start, 0)
				end,
			})

		end,
	},
}
