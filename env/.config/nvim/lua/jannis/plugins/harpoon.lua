return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function()
        local harpoon = require("harpoon")
        local ui = require("harpoon.ui")

        harpoon.setup({
            menu = {
                width = vim.api.nvim_win_get_width(0) - 4,
            }
        })

        -- Dateien hinzufügen direkt über harpoon.add_file
        vim.keymap.set("n", "<leader>a", function() harpoon.add_file() end)
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

        vim.keymap.set("n", "<C-1>", function() ui.nav_file(1) end)
        vim.keymap.set("n", "<C-2>", function() ui.nav_file(2) end)
        vim.keymap.set("n", "<C-3>", function() ui.nav_file(3) end)
        vim.keymap.set("n", "<C-4>", function() ui.nav_file(4) end)
    end
}

