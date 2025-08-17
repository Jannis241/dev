vim.opt.nu = true
vim.opt.relativenumber = true

vim.g.rustfmt_autosave = 1

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

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

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.g.rustaceanvim = {
  tools = {},
  server = {
    on_attach = function(client, bufnr)
      -- deine Keymaps
    end,
    default_settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        checkOnSave = { command = "clippy" },
        imports = {
          granularity = { group = "module" },
          prefix = "self",
        },
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
}

