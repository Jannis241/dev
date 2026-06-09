local function apply(theme)
    vim.cmd.colorscheme(theme)

    -- hintergrund durchsichtig machen
    -- Ist für manche Themes unnötig wenn ich colorschemes.lua
    -- bei der theme config zb transparent = true gemacht wurde
    -- für einige themes jedoch notwendig
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

apply("rose-pine")

