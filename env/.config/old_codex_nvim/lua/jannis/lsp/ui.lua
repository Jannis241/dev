local M = {}

M.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

M.cmp_menu_winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None"
M.cmp_doc_winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocBorder"
M.lsp_winhighlight = "NormalFloat:CmpDocNormal,FloatBorder:CmpDocBorder,FloatTitle:CmpDocBorder"

local function clamp(value, min, max)
	return math.max(min, math.min(max, value))
end

function M.completion_widths()
	return {
		abbr = clamp(math.floor(vim.o.columns * 0.22), 14, 34),
		menu = clamp(math.floor(vim.o.columns * 0.10), 7, 16),
	}
end

function M.docs_size()
	return {
		max_width = clamp(math.floor(vim.o.columns * 0.70), 40, 120),
		max_height = clamp(math.floor(vim.o.lines * 0.65), 12, 30),
	}
end

function M.hover_size()
	return {
		max_width = clamp(math.floor(vim.o.columns * 0.70), 40, 100),
		max_height = clamp(math.floor(vim.o.lines * 0.55), 10, 26),
	}
end

function M.signature_size()
	return {
		max_width = clamp(math.floor(vim.o.columns * 0.70), 40, 100),
		max_height = clamp(math.floor(vim.o.lines * 0.45), 8, 18),
	}
end

function M.lsp_float_config(kind, config)
	local size = kind == "signature" and M.signature_size() or M.hover_size()

	return vim.tbl_deep_extend("force", config or {}, size, {
		border = M.border,
		winhighlight = M.lsp_winhighlight,
	})
end

function M.apply_lsp_float_style(win)
	if win and vim.api.nvim_win_is_valid(win) then
		vim.wo[win].winhighlight = M.lsp_winhighlight
	end
end

return M
