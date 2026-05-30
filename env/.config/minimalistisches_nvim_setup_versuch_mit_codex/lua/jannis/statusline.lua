local M = {}

function M.diagnostics()
	local diagnostics = require("jannis.diagnostics").statusline()
	if diagnostics == "" then
		return ""
	end
	return "[" .. diagnostics .. "]"
end

function M.setup()
	_G.jannis_statusline_diagnostics = M.diagnostics
	vim.o.laststatus = 2
	vim.o.showmode = true
	vim.o.statusline = "%f %m%r%h%w%=%y %{v:lua.jannis_statusline_diagnostics()} %l:%c %p%%"
end

return M
