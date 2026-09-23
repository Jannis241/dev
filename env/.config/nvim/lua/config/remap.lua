vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Makierte Zeilen nach oben oder unten verschieben
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") --

-- Verbindet aktuelle Zeile mit der nächsten Zeile
vim.keymap.set("n", "J", "mzJ`z")

-- Halbe Seite hoch / runter
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Bei Suche (/) : n = nächster Treffer, N = vorheriger Treffer
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy zu System Clipboard
vim.keymap.set({ "n", "v" }, "<C-y>", '"+y')

-- Ganze Seite makieren
vim.keymap.set({ "n", "v", "i" }, "<C-a>", "<esc>gg_vG$")

-- einrücken ohne aus Visual mode zu gehen
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Löschen ohne kopieren
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- Einfügen ohne Buffer zu überschreiben
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Nächster / Vorheriger Quickfix eintrag
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "q", "<cmd>cclose<CR>")

-- Substitutions
vim.keymap.set("n", "<leader>sf", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
    desc = "Substitute word in file",
})

vim.keymap.set("n", "<leader>sl", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
    desc = "Substitute word in current line",
})

vim.keymap.set("x", "<leader>sv", [[:s/\%V//gI<Left><Left><Left><Left>]], {
    desc = "Substitute only inside exact visual selection",
})

vim.keymap.set("n", "<leader>ms", "mM", { desc = "Set return mark" })
vim.keymap.set("n", "<leader>mj", "`M", { desc = "Jump to return mark" })


-- bessere keybinds für programmieren
vim.keymap.set("i", "<M-j>", "{}<esc>i")
vim.keymap.set("i", "<M-k>", "[]<esc>i")
vim.keymap.set("i", "<M-l>", "\\")
vim.keymap.set("i", "<M-i>", "|")
vim.keymap.set("i", "<M-h>", "()<esc>i")
vim.keymap.set("i", "<M-n>", "\"\"<esc>i")
vim.keymap.set("i", "<M-m>", "''<esc>i")
vim.keymap.set("i", "<M-z>", "#")

vim.keymap.set("n", "N", "mMo<esc>`M")





