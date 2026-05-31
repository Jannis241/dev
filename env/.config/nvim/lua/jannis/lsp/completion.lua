local M = {}

function M.setup()
	local cmp = require("cmp")
	local lspkind = require("lspkind")

	local cmp_select = { behavior = cmp.SelectBehavior.Select }
	local cmp_border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

	local function completion_widths()
		return {
			abbr = math.max(14, math.min(34, math.floor(vim.o.columns * 0.22))),
			menu = math.max(7, math.min(16, math.floor(vim.o.columns * 0.10))),
		}
	end

	local function doc_width()
		return math.max(24, math.min(70, math.floor(vim.o.columns * 0.40)))
	end

	local function doc_height()
		return math.max(8, math.min(18, math.floor(vim.o.lines * 0.35)))
	end

	local function bordered_window(opts, extra)
		return vim.tbl_extend("force", cmp.config.window.bordered(opts), extra or {})
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
						return completion_widths().menu
					end,
					abbr = function()
						return completion_widths().abbr
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
			["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
			["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
			["<tab>"] = cmp.mapping.confirm({ select = true }),
			["<enter>"] = cmp.mapping.confirm({ select = true }),
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
				border = cmp_border,
				max_height = 8,
				side_padding = 1,
				scrollbar = false,
				winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None",
				zindex = 1002,
			}),
			documentation = bordered_window({
				border = cmp_border,
				max_height = doc_height(),
				side_padding = 1,
				scrollbar = false,
				winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocBorder",
				zindex = 1001,
			}, {
				max_width = doc_width(),
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
