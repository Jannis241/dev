local M = {}

M.default = "vim"
M.favorites = {
	"vim",
	"default",
	"ayu",
	"rose-pine-moon",
	"catppuccin-mocha",
	"tokyonight-moon",
	"kanagawa-wave",
	"nightfox",
	"gruvbox-material",
	"melange",
	"bamboo",
	"github_dark_default",
}

M.themes = {
	{ name = "Vim Default", colorscheme = "vim" },
	{ name = "Neovim Default", colorscheme = "default" },
	{ name = "Blue", colorscheme = "blue" },
	{ name = "Dark Blue", colorscheme = "darkblue" },
	{ name = "Delek", colorscheme = "delek" },
	{ name = "Elflord", colorscheme = "elflord" },
	{ name = "Koehler", colorscheme = "koehler" },
	{ name = "Morning", colorscheme = "morning" },
	{ name = "Murphy", colorscheme = "murphy" },
	{ name = "Pablo", colorscheme = "pablo" },
	{ name = "Peachpuff", colorscheme = "peachpuff" },
	{ name = "Ron", colorscheme = "ron" },
	{ name = "Shine", colorscheme = "shine" },
	{ name = "Zellner", colorscheme = "zellner" },
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

local builtin_themes = {
	vim = true,
	default = true,
	blue = true,
	darkblue = true,
	delek = true,
	elflord = true,
	koehler = true,
	morning = true,
	murphy = true,
	pablo = true,
	peachpuff = true,
	ron = true,
	shine = true,
	zellner = true,
	desert = true,
	evening = true,
	habamax = true,
	industry = true,
	lunaperche = true,
	quiet = true,
	retrobox = true,
	slate = true,
	sorbet = true,
	torte = true,
	wildcharm = true,
	zaibatsu = true,
}

local plugin_by_colorscheme = {
	ayu = "neovim-ayu",
	embark = "embark",
	brightburn = "brightburn",
	gruvbox = "gruvbox",
	everforest = "everforest",
	dracula = "dracula",
	nord = "nord",
	vscode = "vscode",
	["gruvbox-material"] = "gruvbox-material",
	sonokai = "sonokai",
	edge = "edge",
	melange = "melange",
	material = "material",
	bamboo = "bamboo",
	onenord = "onenord",
	oxocarbon = "oxocarbon",
	nordic = "nordic",
	midnight = "midnight",
	poimandres = "poimandres",
	moonfly = "moonfly",
	nightfly = "nightfly",
	challenger_deep = "challenger-deep",
	xcodedark = "xcode",
	codedark = "codedark",
	mellifluous = "mellifluous",
	zenbones = "zenbones",
	neobones = "zenbones",
	rosebones = "zenbones",
	nordbones = "zenbones",
	forestbones = "zenbones",
	tokyobones = "zenbones",
	vimbones = "zenbones",
	seoulbones = "zenbones",
	duckbones = "zenbones",
}

local plugin_prefixes = {
	{ prefix = "ayu", plugin = "neovim-ayu" },
	{ prefix = "rose-pine", plugin = "rose-pine" },
	{ prefix = "catppuccin", plugin = "catppuccin" },
	{ prefix = "tokyonight", plugin = "tokyonight" },
	{ prefix = "github_", plugin = "github-theme" },
	{ prefix = "kanagawa", plugin = "kanagawa" },
	{ prefix = "nightfox", plugin = "nightfox" },
	{ prefix = "dayfox", plugin = "nightfox" },
	{ prefix = "dawnfox", plugin = "nightfox" },
	{ prefix = "duskfox", plugin = "nightfox" },
	{ prefix = "nordfox", plugin = "nightfox" },
	{ prefix = "terafox", plugin = "nightfox" },
	{ prefix = "carbonfox", plugin = "nightfox" },
	{ prefix = "onedark", plugin = "onedark" },
}

local function plugin_for(colorscheme)
	if builtin_themes[colorscheme] then
		return nil
	end
	if plugin_by_colorscheme[colorscheme] then
		return plugin_by_colorscheme[colorscheme]
	end
	for _, entry in ipairs(plugin_prefixes) do
		if vim.startswith(colorscheme, entry.prefix) then
			return entry.plugin
		end
	end
	return nil
end

local function load_theme_plugin(colorscheme)
	local plugin = plugin_for(colorscheme)
	if not plugin then
		return
	end
	local ok, lazy = pcall(require, "lazy")
	if ok then
		lazy.load({ plugins = { plugin }, show = false })
	end
end

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

function M.apply_basic_highlights()
	local normal = hl("Normal")
	local comment = hl("Comment")
	local diagnostic_info = hl("DiagnosticInfo")
	local fg = color(normal.fg, vim.o.background == "light" and "#1f1f1f" or "#dcdcdc")
	local muted = color(comment.fg or diagnostic_info.fg, vim.o.background == "light" and "#707070" or "#808080")

	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", fg = fg })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = muted })
	vim.api.nvim_set_hl(0, "LineNr", { bg = "none", fg = muted })
	vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none", fg = fg, bold = true })
	vim.api.nvim_set_hl(0, "Pmenu", { bg = "none", fg = fg })
	vim.api.nvim_set_hl(0, "PmenuSel", { reverse = true })
	vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
	vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
end

local function first_line(path)
	local ok, lines = pcall(vim.fn.readfile, path)
	if ok and lines[1] and lines[1] ~= "" then
		return lines[1]
	end
	return nil
end

local function write_state(path, theme)
	local dir = vim.fn.fnamemodify(path, ":h")
	pcall(vim.fn.mkdir, dir, "p")
	pcall(vim.fn.writefile, { theme }, path)
end

local function saved_theme()
	return first_line(state_file) or M.default
end

function M.apply(theme, opts)
	opts = opts or {}
	theme = theme or saved_theme()

	load_theme_plugin(theme)
	local ok, err = pcall(vim.cmd.colorscheme, theme)
	if not ok then
		vim.notify("Theme konnte nicht geladen werden: " .. theme .. "\n" .. err, vim.log.levels.ERROR)
		return
	end

	M.apply_basic_highlights()
	if opts.persist ~= false then
		write_state(state_file, theme)
	end
end

local function complete(arg_lead)
	local matches = {}
	for _, theme in ipairs(M.themes) do
		if vim.startswith(theme.colorscheme, arg_lead) then
			table.insert(matches, theme.colorscheme)
		end
	end
	return matches
end

function M.setup()
	M.apply(saved_theme(), { persist = false })

	vim.api.nvim_create_autocmd("ColorScheme", {
		group = vim.api.nvim_create_augroup("jannis_theme", { clear = true }),
		callback = M.apply_basic_highlights,
	})

	vim.api.nvim_create_user_command("Theme", function(opts)
		if opts.args == "" then
			vim.api.nvim_echo({ { "Current theme: " .. saved_theme() .. "\nUse :Theme <colorscheme>", "Normal" } }, false, {})
			return
		end
		M.apply(opts.args)
	end, {
		nargs = "?",
		complete = complete,
		desc = "Change colorscheme",
	})
end

return M
