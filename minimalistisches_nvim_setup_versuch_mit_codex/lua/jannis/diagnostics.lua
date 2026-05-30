local M = {}

local severity = vim.diagnostic.severity
local severity_order = {
	severity.ERROR,
	severity.WARN,
	severity.INFO,
	severity.HINT,
}
local severity_labels = {
	[severity.ERROR] = "E",
	[severity.WARN] = "W",
	[severity.INFO] = "I",
	[severity.HINT] = "H",
}

M.all = false
M.default_severity = severity.ERROR

M.severity_by_filetype = {
	c = M.all,
	cpp = M.all,
	rust = severity.ERROR,
}

function M.severity(bufnr)
	local ft = vim.bo[bufnr or 0].filetype
	local configured = M.severity_by_filetype[ft]

	if configured == M.all then
		return nil
	end

	return configured or M.default_severity
end

function M.with_severity(opts, bufnr)
	local result = vim.deepcopy(opts or {})
	local configured = M.severity(bufnr)

	if configured ~= nil then
		result.severity = configured
	end

	return result
end

function M.virtual_text(_, bufnr)
	return M.with_severity({
		prefix = ">",
		spacing = 2,
	}, bufnr)
end

function M.signs(_, bufnr)
	return M.with_severity({}, bufnr)
end

function M.underline(_, bufnr)
	return M.with_severity({}, bufnr)
end

function M.float_opts(bufnr, opts)
	return M.with_severity(
		vim.tbl_extend("force", {
			border = "single",
			source = "if_many",
			header = "",
			prefix = "",
		}, opts or {}),
		bufnr
	)
end

function M.float(_, bufnr)
	return M.float_opts(bufnr)
end

function M.filter(opts, bufnr)
	return M.with_severity(opts, bufnr)
end

function M.statusline()
	local configured = M.severity(0)
	local opts = configured and { severity = configured } or nil
	local counts = {}

	for _, diagnostic in ipairs(vim.diagnostic.get(0, opts)) do
		counts[diagnostic.severity] = (counts[diagnostic.severity] or 0) + 1
	end

	local parts = {}
	for _, level in ipairs(severity_order) do
		local count = counts[level]
		if count and count > 0 then
			table.insert(parts, severity_labels[level] .. count)
		end
	end

	return table.concat(parts, " ")
end

return M
