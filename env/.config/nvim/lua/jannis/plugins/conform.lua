return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                -- <leader> f um zu formatten oder in settings auf automatisch stellen zb rustfmt_auto = 1 oder so
                lua = { "stylua" },
                go = { "gofmt" },
                rust = {"rustfmt"},
                -- todo: weitere formats für python, c++ java usw machen -> muss man aber erst noch selber runterladen
            }
        })
    end
}

