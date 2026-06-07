return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local harpoon = require("harpoon").setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
				tabline = true,
				tabline_prefix = "   ",
				tabline_suffix = "   ",
			},
			menu = {
				width = vim.api.nvim_win_get_width(0) - 4,
			},
		})

		harpoon:setup({})
		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<leader>qm", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)
		vim.keymap.set("n", "<leader>1", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<leader>2", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<leader>3", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<leader>4", function()
			harpoon:list():select(4)
		end)
		local function harpoon_files()
			local contents = {}
			local list = harpoon:list()
			local current_file = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")

			for index = 1, list:length() do
				local item = list:get(index)

				-- wirklich leere Harpoon-Slots überspringen
				if item and item.value and item.value ~= "" then
					local path = item.value
					local name = vim.fn.fnamemodify(path, ":t")

					if path == current_file then
						table.insert(
							contents,
							string.format("%%#HarpoonNumberActive# %d. %%#HarpoonActive#%s ", index, name)
						)
					else
						table.insert(
							contents,
							string.format("%%#HarpoonNumberInactive# %d. %%#HarpoonInactive#%s ", index, name)
						)
					end
				end
			end

			return table.concat(contents, " ")
		end

		vim.opt.showtabline = 2

		vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "BufDelete", "User" }, {
			callback = function()
				local s = harpoon_files()

				if s == "" then
					vim.o.showtabline = 0
					vim.o.tabline = ""
				else
					vim.o.showtabline = 2
					vim.o.tabline = s
				end
			end,
		})
	end,
}
