# Plugins

Alle Plugins werden ueber `lazy.nvim` geladen. Die Specs liegen in `lua/jannis/plugins`.

## Core

### `lazy.nvim`

Wird in `lua/jannis/init.lua` gebootstrapped. Falls Lazy noch nicht in `stdpath("data") .. "/lazy/lazy.nvim"` liegt, wird es per Git geklont.

Config:

- `install.missing = true`: Fehlende Plugins werden automatisch installiert.
- `checker.enabled = false`: Keine automatischen Update-Checks beim Start.
- `change_detection.notify = false`: Keine Stoer-Meldungen bei Plugin-Spec-Aenderungen.

### `plenary.nvim`

Hilfsbibliothek fuer viele Plugins. In `plugins/init.lua` als `plenary` benannt und lazy geladen, wenn ein Plugin es als Dependency braucht.

## UI und Navigation

### `telescope.nvim`

Zentrale Suchoberflaeche.

Lazy Loading:

- Command `:Telescope`
- Telescope-Keymaps wie `<leader>pf`, `<leader>ps`, `<leader>fb`

Dependencies:

- `plenary.nvim`
- `telescope-fzf-native.nvim`
- `telescope-ui-select.nvim`

Features:

- FZF Native fuer schnelleres fuzzy sorting.
- `ui-select` ersetzt `vim.ui.select` durch Telescope-Dropdowns.
- Prompt oben, ascending sorting.
- Hidden files werden bei `find_files` angezeigt.

Keymaps:

- `<leader>pf`: Dateien suchen.
- `<leader>pws`: Im aktuellen Buffer suchen.
- `<leader>ps`: Live grep.
- `<leader>fb`: Buffer suchen.
- `<leader>fh`: Help tags suchen.

### `neo-tree.nvim`

File Explorer.

Lazy Loading:

- Wird ueber Command `:Neotree` geladen.

Features:

- Float-Fenster.
- Rounded Border.
- Git Status und Diagnostics aktiv.
- Dotfiles und gitignored files werden nicht versteckt.
- `.DS_Store` und `thumbs.db` werden immer versteckt.
- File size, type, last modified und created koennen je nach Fensterbreite angezeigt werden.

Globale Keymaps:

- `\`: `Neotree reveal`
- `<leader>pv`: `:Neotree`

Neo-tree interne Mappings:

- `<esc>`: Cancel/Preview schliessen.
- `P`: Preview togglen.
- `D`: Directory anlegen.
- `d`: Loeschen.
- `r`: Umbenennen.
- `y`: In Clipboard kopieren.
- `x`: Ausschneiden.
- `p`: Einfuegen.
- `c`: Kopieren.
- `m`: Verschieben.
- `q`: Fenster schliessen.
- `R`: Refresh.
- `?`: Help.
- `<` / `>`: Source wechseln.
- `i`: File Details zeigen.

### `lualine.nvim`

Statusline.

Lazy Loading:

- `VeryLazy`

Features:

- Theme: `auto`
- Zeigt Mode, Branch, Diff, Diagnostics, Dateiname mit Pfad, Filetype, Progress und Location.
- Extensions fuer Fugitive, nvim-tree und Quickfix.
- Statusline-Hintergrund wird transparent gesetzt.

### `nvim-web-devicons`

Icon-Unterstuetzung fuer Neo-tree, Lualine, Trouble und andere Plugins.
Wird lazy als Dependency geladen.

### `dressing.nvim`

Verbessert `vim.ui.input` und `vim.ui.select`.

Features:

- Inputs mit rounded Border.
- Select nutzt bevorzugt Telescope, sonst builtin.
- `winblend = 0`, also keine halbtransparenten Input-Fenster.

## LSP, Completion und Sprache

### `nvim-lspconfig`

Zentrale LSP-Konfiguration. Siehe `lsp-formatting-diagnostics.md`.

Lazy Loading:

- `BufReadPre`
- `BufNewFile`

### `mason.nvim`

Installiert und verwaltet externe Tools und LSP-Server.

### `mason-lspconfig.nvim`

Verbindet Mason und LSPConfig. Auto-enabled alle konfigurierten Server ausser `rust_analyzer`.

### `mason-tool-installer.nvim`

Installiert automatisch:

- `black`
- `google-java-format`
- `prettier`
- `rust-analyzer`
- `stylua`

`run_on_start` ist nur in interaktiven Neovim-UIs aktiv, nicht in Headless/CI. Mit `start_delay = 3000` und `auto_update = false` blockiert das den Start nicht und installiert nur fehlende Tools, statt bei jedem Start alles neu zu installieren.

### `nvim-cmp`

Completion-Engine mit Sources fuer LSP, Snippets und Buffer.

UI:

- Completion und Dokumentation nutzen bordered Float-Fenster mit transparentem Hintergrund.
- Completion-Eintraege werden dynamisch begrenzt, damit neben der Completion Platz fuer die Dokumentation bleibt.
- Nur der aktuelle Completion-Eintrag hat einen gefuellten Selection-Hintergrund.
- Die Dokumentation wird seitlich neben der Completion platziert; falls Floats auf engem Raum konkurrieren, liegt die Completion ueber der Dokumentation.
- Completion-Dokumentation kann mit `<C-f>`/`<C-b>` gescrollt werden.
- Hover- und Signature-Help-Infos folgen dem gleichen transparenten Float-Stil.

### `cmp-nvim-lsp`, `cmp-buffer`, `cmp_luasnip`

Completion-Sources fuer LSP, Buffer und LuaSnip.

### `LuaSnip`

Snippet Engine.

Dependency:

- `friendly-snippets`

Keymaps:

- `<C-s>e`: Snippet expandieren.
- `<C-s>;`: Naechster Snippet-Jump.
- `<C-s>,`: Vorheriger Snippet-Jump.
- `<C-E>`: Choice wechseln.

### `lspkind.nvim`

Icons und Text fuer Completion-Eintraege. Nutzt `codicons` Preset plus eigene Symbol-Map.

### `fidget.nvim`

Zeigt LSP-Progress, z. B. Rust Analyzer Ladefortschritt.

### `conform.nvim`

Formatter-Integration und Auto-Format on Save fuer Rust, Python und Java. Siehe `lsp-formatting-diagnostics.md`.

Lazy Loading:

- `BufWritePre`

### `rustaceanvim`

Rust-spezifischer LSP-Wrapper und Rust-Tools. Wird nur fuer Rust-Dateien geladen.

### `crates.nvim`

Unterstuetzt `Cargo.toml`.

Lazy Loading:

- `BufRead Cargo.toml`

Feature:

- Completion fuer Crates ist ueber `cmp` aktiviert.

### `php.nvim`

PHP-Support von `tjdevries/php.nvim`. Haengt an Treesitter.

Lazy Loading:

- Nur fuer Filetype `php`.

## Syntax und Treesitter

### `nvim-treesitter`

Parser-Management und Syntax-Highlighting.

Parser, die installiert werden:

- `vimdoc`
- `javascript`
- `typescript`
- `c`
- `lua`
- `rust`
- `python`
- `jsdoc`
- `bash`
- `go`
- `java`
- `cpp`
- `c_sharp`
- `templ`

Custom Parser:

- `templ` von `https://github.com/vrischmann/tree-sitter-templ.git`

Beim `VeryLazy`-Event werden nur fehlende Parser installiert. Bei jedem Filetype wird versucht, Treesitter zu starten und Treesitter-Indent zu setzen. Dateien ueber 1 MiB oder 10000 Zeilen werden ausgelassen, damit sehr grosse Dateien nicht durch Parsing oder Sticky Context ausgebremst werden.

### `nvim-treesitter-context`

Sticky Context am oberen Fensterrand.

Sehr grosse Dateien werden nicht attached, weil der Context dort mehr kostet als er im Alltag bringt.

Lazy Loading:

- `BufReadPost`
- `BufNewFile`

Config:

- Aktiviert.
- Maximal 3 Zeilen.
- Line Numbers aktiv.
- Modus: `cursor`.

## Git

### `vim-fugitive`

Git-Integration in Vim.

Lazy Loading:

- Command `:Git` / `:G`
- Keymaps `<leader>gs`, `gu`, `gh`

Keymaps:

- `<leader>gs`: Git-Status/Fugitive oeffnen.
- In Fugitive-Buffern: push, pull --rebase, push upstream vorbereiten.
- `gu` und `gh`: Diffget fuer Merge-Konflikte.

### `gitsigns.nvim`

Git-Zeichen in der Signcolumn und Hunk-Aktionen.

Features:

- Git-Hunks navigieren.
- Hunks stagen/resetten.
- Hunk preview.
- Blame line.
- Toggle current line blame.
- Diff fuer aktuelle Datei.

## Diagnostics und Aufgaben

### `trouble.nvim`

Listenansicht fuer Diagnostics und Quickfix.

Keymaps:

- `<leader>fe`: File Errors.
- `<leader>pe`: Project Errors.
- `<leader>qf`: Quickfix in Trouble.

`<leader>e` bleibt ein vollstaendiges Mapping fuer den Error-Float der aktuellen Zeile; `<leader>fe` und `<leader>pe` oeffnen die fokussierte Trouble-Liste.

Config:

- Oeffnet rechts.
- Fokussiert die Trouble-Liste.
- `j`/`k` gehen durch die Error-Eintraege und zeigen die jeweilige Code-Stelle als Preview.
- `Enter` springt zum Eintrag und schliesst Trouble.
- Auto Preview ist aktiv.

### `todo-comments.nvim`

Hebt TODO/FIXME/HACK/WARN/PERF/NOTE hervor.

Keywords:

- `FIX`, `FIXME`, `BUG`, `FIXIT`, `ISSUE`
- `TODO`, `Todo`, `todo`
- `HACK`
- `WARN`, `WARNING`, `XXX`
- `PERF`, `OPTIM`, `PERFORMANCE`, `OPTIMIZE`
- `NOTE`, `INFO`

Todo-Kommentare werden mit und ohne Doppelpunkt erkannt.

Keymaps:

- `<leader>nt`, `<leader>pt`, `<leader>ft`, `<leader>xt`

## Editing

### `nvim-autopairs`

Automatisches Schliessen von Klammern, Quotes usw.

Lazy Loading:

- `InsertEnter`

### `undotree`

Visualisiert Undo-History.

Keymap:

- `<leader>u`

### `harpoon`

Schnelle Projekt-Navigation ueber eine kleine Liste wichtiger Dateien.
Harpoon ist praktisch fuer Dateien, zwischen denen du oft wechselst, ohne jedes Mal Telescope oder Neo-tree zu oeffnen.

Lazy Loading:

- Ueber Harpoon-Keymaps.

Keymaps:

- `<leader>ma`: Aktuelle Datei zur Harpoon-Liste hinzufuegen.
- `<leader>mm`: Harpoon-Menue oeffnen.
- `<leader>1` bis `<leader>4`: Direkt zu den ersten vier Harpoon-Dateien springen.
- `<leader>mn`: Naechste Harpoon-Datei.
- `<leader>mp`: Vorherige Harpoon-Datei.

## Themes

Alle Theme-Plugins sind in `themes.lua` lazy. Details stehen in `themes.md`.

## Leere oder organisatorische Plugin-Dateien

### `fzf.lua`

Enthaelt absichtlich keine eigene Plugin-Spec. `telescope-fzf-native.nvim` ist als Dependency von Telescope definiert.
