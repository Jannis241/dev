
-- lua/plugins/harpoon.lua
return {
  "ThePrimeagen/harpoon",
  keys = {
    { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Add file to Harpoon" },
    { "<leader>h", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle Harpoon menu" },
    { "<leader>1", function() require("harpoon.ui").nav_file(1) end, desc = "Go to Harpoon file 1" },
    { "<leader>2", function() require("harpoon.ui").nav_file(2) end, desc = "Go to Harpoon file 2" },
    { "<leader>3", function() require("harpoon.ui").nav_file(3) end, desc = "Go to Harpoon file 3" },
    { "<leader>4", function() require("harpoon.ui").nav_file(4) end, desc = "Go to Harpoon file 4" },
  },
  config = function()
    local harpoon = require("harpoon")
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    -- Optional: weitere Keymaps
    vim.keymap.set("n", "<leader>m", mark.add_file, { desc = "Add file to Harpoon" })
    vim.keymap.set("n", "<leader>n", ui.toggle_quick_menu, { desc = "Toggle Harpoon menu" })
  end
}

