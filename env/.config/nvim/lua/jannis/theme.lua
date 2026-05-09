local M = {}

M.default = "ayu"

M.themes = {
	{ name = "Ayu", colorscheme = "ayu" },
	{ name = "Ayu Dark", colorscheme = "ayu-dark" },
	{ name = "Ayu Mirage", colorscheme = "ayu-mirage" },
	{ name = "Ayu Light", colorscheme = "ayu-light" },
	{ name = "Rose Pine Main", colorscheme = "rose-pine-main" },
	{ name = "Rose Pine Moon", colorscheme = "rose-pine-moon" },
	{ name = "Rose Pine Dawn", colorscheme = "rose-pine-dawn" },
	{ name = "Rose Pine", colorscheme = "rose-pine" },
	{ name = "Catppuccin Mocha", colorscheme = "catppuccin-mocha" },
	{ name = "Catppuccin Macchiato", colorscheme = "catppuccin-macchiato" },
	{ name = "Catppuccin Frappe", colorscheme = "catppuccin-frappe" },
	{ name = "Catppuccin Latte", colorscheme = "catppuccin-latte" },
	{ name = "Tokyo Night Night", colorscheme = "tokyonight-night" },
	{ name = "Tokyo Night Storm", colorscheme = "tokyonight-storm" },
	{ name = "Tokyo Night Moon", colorscheme = "tokyonight-moon" },
	{ name = "Tokyo Night Day", colorscheme = "tokyonight-day" },
	{ name = "Tokyo Night", colorscheme = "tokyonight" },
	{ name = "Gruvbox", colorscheme = "gruvbox" },
	{ name = "GitHub Dark", colorscheme = "github_dark" },
	{ name = "GitHub Dark Default", colorscheme = "github_dark_default" },
	{ name = "GitHub Dark Dimmed", colorscheme = "github_dark_dimmed" },
	{ name = "GitHub Dark High Contrast", colorscheme = "github_dark_high_contrast" },
	{ name = "GitHub Dark Colorblind", colorscheme = "github_dark_colorblind" },
	{ name = "GitHub Dark Tritanopia", colorscheme = "github_dark_tritanopia" },
	{ name = "GitHub Light", colorscheme = "github_light" },
	{ name = "GitHub Light Default", colorscheme = "github_light_default" },
	{ name = "GitHub Light High Contrast", colorscheme = "github_light_high_contrast" },
	{ name = "GitHub Light Colorblind", colorscheme = "github_light_colorblind" },
	{ name = "GitHub Light Tritanopia", colorscheme = "github_light_tritanopia" },
	{ name = "Kanagawa Wave", colorscheme = "kanagawa-wave" },
	{ name = "Kanagawa Dragon", colorscheme = "kanagawa-dragon" },
	{ name = "Kanagawa Lotus", colorscheme = "kanagawa-lotus" },
	{ name = "Nightfox", colorscheme = "nightfox" },
	{ name = "Dayfox", colorscheme = "dayfox" },
	{ name = "Dawnfox", colorscheme = "dawnfox" },
	{ name = "Duskfox", colorscheme = "duskfox" },
	{ name = "Nordfox", colorscheme = "nordfox" },
	{ name = "Terafox", colorscheme = "terafox" },
	{ name = "Carbonfox", colorscheme = "carbonfox" },
	{ name = "Onedark", colorscheme = "onedark" },
	{ name = "Everforest", colorscheme = "everforest" },
	{ name = "Dracula", colorscheme = "dracula" },
	{ name = "Nord", colorscheme = "nord" },
	{ name = "VS Code Dark", colorscheme = "vscode" },
	{ name = "Gruvbox Material", colorscheme = "gruvbox-material" },
	{ name = "Sonokai", colorscheme = "sonokai" },
	{ name = "Edge", colorscheme = "edge" },
	{ name = "Melange", colorscheme = "melange" },
	{ name = "Material", colorscheme = "material" },
	{ name = "Bamboo", colorscheme = "bamboo" },
	{ name = "Onenord", colorscheme = "onenord" },
	{ name = "Oxocarbon", colorscheme = "oxocarbon" },
	{ name = "Nordic", colorscheme = "nordic" },
	{ name = "Midnight", colorscheme = "midnight" },
	{ name = "Poimandres", colorscheme = "poimandres" },
	{ name = "Moonfly", colorscheme = "moonfly" },
	{ name = "Nightfly", colorscheme = "nightfly" },
	{ name = "Challenger Deep", colorscheme = "challenger_deep" },
	{ name = "Xcode Dark", colorscheme = "xcodedark" },
	{ name = "Code Dark", colorscheme = "codedark" },
	{ name = "Mellifluous", colorscheme = "mellifluous" },
	{ name = "Zenbones", colorscheme = "zenbones" },
	{ name = "Neobones", colorscheme = "neobones" },
	{ name = "Rosebones", colorscheme = "rosebones" },
	{ name = "Nordbones", colorscheme = "nordbones" },
	{ name = "Forestbones", colorscheme = "forestbones" },
	{ name = "Tokyobones", colorscheme = "tokyobones" },
	{ name = "Vimbones", colorscheme = "vimbones" },
	{ name = "Seoulbones", colorscheme = "seoulbones" },
	{ name = "Duckbones", colorscheme = "duckbones" },
	{ name = "Habamax", colorscheme = "habamax" },
	{ name = "Retrobox", colorscheme = "retrobox" },
	{ name = "Wildcharm", colorscheme = "wildcharm" },
	{ name = "Sorbet", colorscheme = "sorbet" },
	{ name = "Zaibatsu", colorscheme = "zaibatsu" },
	{ name = "Desert", colorscheme = "desert" },
	{ name = "Evening", colorscheme = "evening" },
	{ name = "Slate", colorscheme = "slate" },
	{ name = "Torte", colorscheme = "torte" },
	{ name = "Industry", colorscheme = "industry" },
	{ name = "Lunaperche", colorscheme = "lunaperche" },
	{ name = "Quiet", colorscheme = "quiet" },
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
