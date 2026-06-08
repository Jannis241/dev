local M = {}

function M.setup()
	local cmp = require("cmp")
	local lspkind = require("lspkind")
	local ui = require("jannis.lsp.ui")

	local cmp_select = { behavior = cmp.SelectBehavior.Select }
	local cmp_confirm = { behavior = cmp.ConfirmBehavior.Insert, select = true }

	local function bordered_window(opts, extra)
		return vim.tbl_extend("force", cmp.config.window.bordered(opts), extra or {})
	end

	local function select_or_scroll_docs(delta)
		return cmp.mapping(function(fallback)
			if cmp.visible_docs() then
				cmp.scroll_docs(delta)
			elseif cmp.visible() then
				if delta > 0 then
					cmp.select_next_item(cmp_select)
				else
					cmp.select_prev_item(cmp_select)
				end
			else
				fallback()
			end
		end, { "i", "s" })
	end

	cmp.setup({
		completion = {
			completeopt = "menu,menuone,noinsert",
		},
		view = {
			entries = {
				name = "custom",
				selection_order = "top_down",
				vertical_positioning = "below",
				follow_cursor = false,
			},
			docs = {
				auto_open = false,
			},
		},
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				maxwidth = {
					menu = function()
						return ui.completion_widths().menu
					end,
					abbr = function()
						return ui.completion_widths().abbr
					end,
				},
				ellipsis_char = "...",
				show_labelDetails = false,
				before = function(_, vim_item)
					return vim_item
				end,
			}),
		},
		snippet = {
			expand = function() end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = select_or_scroll_docs(-4),
			["<C-j>"] = select_or_scroll_docs(4),
			["<tab>"] = cmp.mapping.confirm(cmp_confirm),
			["<enter>"] = cmp.mapping.confirm(cmp_confirm),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-d>"] = cmp.mapping(function()
				if cmp.visible_docs() then
					cmp.close_docs()
				else
					cmp.open_docs()
				end
			end, { "i", "s" }),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
		}),
		window = {
			completion = bordered_window({
				border = ui.border,
				max_height = 8,
				side_padding = 1,
				scrollbar = false,
				winhighlight = ui.cmp_menu_winhighlight,
				zindex = 1002,
			}),
			documentation = bordered_window({
				border = ui.border,
				max_height = ui.docs_size().max_height,
				side_padding = 1,
				scrollbar = false,
				winhighlight = ui.cmp_doc_winhighlight,
				zindex = 1001,
			}, {
				max_width = ui.docs_size().max_width,
			}),
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
		}, {
			{ name = "buffer" },
		}),
	})
end

return M
