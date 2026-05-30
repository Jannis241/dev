vim.env.LANG = "C"
vim.env.LANGUAGE = "en"
pcall(vim.cmd, "language messages C")

vim.opt.guicursor = "a:block"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.g.rustaceanvim = {
	server = {
		settings = {
			["rust-analyzer"] = {
				checkOnSave = true,
				inlayHints = {
					lifetimeElisionHints = { enable = true, useParameterNames = true },
					parameterHints = true,
					typeHints = true,
					chainingHints = true,
				},
			},
		},
	},
	dap = {},
	tools = {},
}
