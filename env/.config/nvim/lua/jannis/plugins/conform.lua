return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                go = { "gofmt" },
                rust = { "rustfmt" },
                python = { "black" },
                javascript = { "prettier" },
                typescript = { "prettier" },
            }
        })
    end
}
