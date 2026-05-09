local M = {}

M.default = "ayu"

M.themes = {
	{ name = "Ayu", colorscheme = "ayu" },
	{ name = "Rose Pine Moon", colorscheme = "rose-pine-moon" },
	{ name = "Rose Pine", colorscheme = "rose-pine" },
	{ name = "Catppuccin Mocha", colorscheme = "catppuccin-mocha" },
	{ name = "Catppuccin Macchiato", colorscheme = "catppuccin-macchiato" },
	{ name = "Tokyo Night", colorscheme = "tokyonight" },
	{ name = "Tokyo Night Moon", colorscheme = "tokyonight-moon" },
	{ name = "Gruvbox", colorscheme = "gruvbox" },
	{ name = "GitHub Dark", colorscheme = "github_dark" },
	{ name = "GitHub Dark Default", colorscheme = "github_dark_default" },
	{ name = "Kanagawa Wave", colorscheme = "kanagawa-wave" },
	{ name = "Kanagawa Dragon", colorscheme = "kanagawa-dragon" },
	{ name = "Nightfox", colorscheme = "nightfox" },
	{ name = "Duskfox", colorscheme = "duskfox" },
	{ name = "Onedark", colorscheme = "onedark" },
	{ name = "Everforest", colorscheme = "everforest" },
	{ name = "Dracula", colorscheme = "dracula" },
	{ name = "Nord", colorscheme = "nord" },
	{ name = "VS Code Dark", colorscheme = "vscode" },
	{ name = "Embark", colorscheme = "embark" },
	{ name = "Brightburn", colorscheme = "brightburn" },
}

local state_file = vim.fn.stdpath("state") .. "/jannis-theme"

local function hl(name)
	local ok, value = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
	if ok then
		return value
	end
	return {}
end

local function color(value, fallback)
	if type(value) == "number" then
		return string.format("#%06x", value)
	end
	return fallback
end

function M.apply_float_highlights()
	local normal = hl("Normal")
	local pmenu = hl("Pmenu")
	local diagnostic_info = hl("DiagnosticInfo")
	local type_hl = hl("Type")
	local comment = hl("Comment")

	local bg = color(pmenu.bg, vim.o.background == "light" and "#f0f0f0" or "#1f2335")
	local fg = color(normal.fg, vim.o.background == "light" and "#1f1f1f" or "#dcdcdc")
	local border =
		color(diagnostic_info.fg or type_hl.fg or comment.fg, vim.o.background == "light" and "#5f5f87" or "#7aa2f7")
	local line_nr = color(comment.fg or type_hl.fg, vim.o.background == "light" and "#707070" or "#7c7c7c")

	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", fg = fg })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = border })
	vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none", fg = border, bold = true })
	vim.api.nvim_set_hl(0, "LineNr", { bg = "none", fg = line_nr })
	vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none", fg = border, bold = true })
	vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "FloatBorder" })
	vim.api.nvim_set_hl(0, "CmpDocumentation", { link = "NormalFloat" })
	vim.api.nvim_set_hl(0, "CmpDocumentationBorder", { link = "FloatBorder" })
end

local function saved_theme()
	local ok, lines = pcall(vim.fn.readfile, state_file)
	if ok and lines[1] and lines[1] ~= "" then
		return lines[1]
	end
	return M.default
end

local function persist(theme)
	local dir = vim.fn.fnamemodify(state_file, ":h")
	pcall(vim.fn.mkdir, dir, "p")
	pcall(vim.fn.writefile, { theme }, state_file)
end

function M.apply(theme, opts)
	opts = opts or {}
	theme = theme or saved_theme()

	local ok, err = pcall(vim.cmd.colorscheme, theme)
	if not ok then
		vim.notify("Theme konnte nicht geladen werden: " .. theme .. "\n" .. err, vim.log.levels.ERROR)
		return
	end

	M.apply_float_highlights()
	if opts.persist ~= false then
		persist(theme)
	end
end

function M.pick()
	local ok, pickers = pcall(require, "telescope.pickers")
	if not ok then
		vim.ui.select(M.themes, {
			prompt = "Theme",
			format_item = function(item)
				return item.name
			end,
		}, function(item)
			if item then
				M.apply(item.colorscheme)
			end
		end)
		return
	end

	local finders = require("telescope.finders")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local conf = require("telescope.config").values
	local dropdown = require("telescope.themes").get_dropdown({
		previewer = false,
		prompt_title = "Change Theme",
		width = 0.45,
	})

	pickers
		.new(dropdown, {
			finder = finders.new_table({
				results = M.themes,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry.name .. "  " .. entry.colorscheme,
						ordinal = entry.name .. " " .. entry.colorscheme,
					}
				end,
			}),
			sorter = conf.generic_sorter(dropdown),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					if selection then
						M.apply(selection.value.colorscheme)
					end
				end)
				return true
			end,
		})
		:find()
end

function M.setup()
	M.apply(saved_theme(), { persist = false })
	M.apply_float_highlights()

	vim.api.nvim_create_autocmd("ColorScheme", {
		group = vim.api.nvim_create_augroup("jannis_theme", { clear = true }),
		callback = M.apply_float_highlights,
	})

	local hover = vim.lsp.handlers.hover
	vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
		config = vim.tbl_deep_extend("force", config or {}, {
			border = "rounded",
			max_width = 90,
			max_height = 24,
		})
		return hover(err, result, ctx, config)
	end

	local signature_help = vim.lsp.handlers.signature_help
	vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
		config = vim.tbl_deep_extend("force", config or {}, {
			border = "rounded",
			max_width = 90,
			max_height = 16,
		})
		return signature_help(err, result, ctx, config)
	end

	vim.api.nvim_create_user_command("Theme", M.pick, { desc = "Change colorscheme" })
	vim.keymap.set("n", "<C-c>t", M.pick, { desc = "Change theme" })
	vim.keymap.set("n", "<C-t>", M.pick, { desc = "Change theme" })
	vim.keymap.set("n", "<leader>ct", M.pick, { desc = "Change theme" })
end

return M
