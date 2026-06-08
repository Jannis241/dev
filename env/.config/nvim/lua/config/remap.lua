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

-- Erstellt automatisch ein Substitute Befehl für das Wort unter dem Cursor (nur für das eine File)
-- global
vim.keymap.set("n", "<leader>sg", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("x", "<leader>sv", [[:s///gI<Left><Left><Left>]], {
    desc = "Substitute in visual selection",
})

vim.keymap.set("n", "<leader>ms", "mM", { desc = "Set return mark" })
vim.keymap.set("n", "<leader>mj", "`M", { desc = "Jump to return mark" })
