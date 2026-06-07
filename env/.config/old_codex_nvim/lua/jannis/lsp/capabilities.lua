local M = {}

local function cmp_completion_capabilities()
	return {
		textDocument = {
			completion = {
				dynamicRegistration = false,
				completionItem = {
					snippetSupport = false,
					commitCharactersSupport = true,
					deprecatedSupport = true,
					preselectSupport = true,
					tagSupport = {
						valueSet = { 1 },
					},
					insertReplaceSupport = true,
					resolveSupport = {
						properties = {
							"documentation",
							"additionalTextEdits",
							"insertTextFormat",
							"insertTextMode",
							"command",
						},
					},
					insertTextModeSupport = {
						valueSet = { 1, 2 },
					},
					labelDetailsSupport = true,
				},
				contextSupport = true,
				insertTextMode = 1,
				completionList = {
					itemDefaults = {
						"commitCharacters",
						"editRange",
						"insertTextFormat",
						"insertTextMode",
						"data",
					},
				},
			},
		},
	}
end

function M.make(...)
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	for _, extra in ipairs({ ... }) do
		if type(extra) == "table" then
			capabilities = vim.tbl_deep_extend("force", capabilities, extra)
		end
	end

	capabilities = vim.tbl_deep_extend("force", capabilities, cmp_completion_capabilities())
	capabilities.textDocument.completion.completionItem.snippetSupport = false

	return capabilities
end

return M
