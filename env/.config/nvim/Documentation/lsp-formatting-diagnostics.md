# LSP, Completion, Formatting und Diagnostics

## LSP-Setup

Das LSP-Setup liegt in `lua/jannis/plugins/lsp.lua`.

Verwendete Bausteine:

- `nvim-lspconfig`: Startet und konfiguriert LSP-Server.
- `mason.nvim`: Verwaltet LSP-Server und externe Tools.
- `mason-lspconfig.nvim`: Verbindet Mason mit LSPConfig.
- `mason-tool-installer.nvim`: Installiert Formatter/Tools automatisch.
- `cmp-nvim-lsp`: Erweitert LSP-Capabilities fuer Completion.
- `nvim-cmp`: Completion-Engine mit bordered Completion- und Dokumentations-Floats.
- `LuaSnip` und `cmp_luasnip`: Snippet-Expansion in Completion.
- `fidget.nvim`: LSP-Fortschritt rechts im Editor.
- `lazydev.nvim`: LuaLS-Unterstuetzung fuer Neovim-Config-Entwicklung.
- `nvim-lint`: Asynchrones Linting neben LSP.

## Installierte LSP-Server

Mason stellt diese LSP-Server sicher:

- `lua_ls`
- `jdtls`
- `pyright`
- `gopls`
- `clangd`

`rust_analyzer` ist absichtlich ausgeschlossen. Rust wird ueber `rustaceanvim` gesteuert, damit Rust Analyzer nicht doppelt attached.
Der `rust-analyzer`-Binary wird trotzdem ueber `mason-tool-installer` installiert, damit Rust auf einem frischen System direkt nutzbar ist.

## Rust

Rust liegt in zwei Dateien:

- `set.lua`: `vim.g.rustaceanvim` Grundsettings fuer Rust Analyzer.
- `plugins/rustacean.lua`: Lazy-Plugin fuer Rust-spezifische Commands und Keymaps.

Features:

- Rust Analyzer startet nur fuer Rust-Dateien.
- `checkOnSave = true`
- Inlay Hints fuer Lifetimes, Parameter, Types und Chaining.
- Rust-spezifische Keymaps:
  - `<leader>ra`: Hover Actions.
  - `<leader>rd`: Diagnostic rendern.
  - `<leader>od`: Rust Docs oeffnen.

## Java

Java nutzt:

- LSP: `jdtls`
- Formatter: `google-java-format`
- Auto-Format on Save: aktiv

## Python

Python nutzt:

- LSP: `pyright`
- Formatter: `black`
- Auto-Format on Save: aktiv

## Lua

Lua nutzt:

- LSP: `lua_ls`
- Formatter: `stylua` ist per Mason-Tool-Installer installiert.
- `lazydev.nvim` stellt Neovim-/luv-Libraries fuer bessere LuaLS-Completion und Diagnostics bereit.
- Kein Auto-Format on Save in der aktuellen Config, aber manuelles Formatieren ueber `<leader>f` geht, wenn Conform fuer den Filetype einen Formatter kennt.

## Shell

Shell-Dateien nutzen:

- Formatter: `shfmt`
- Linter: `shellcheck` ueber `nvim-lint`
- Manuelles Linting: `<leader>ll`

## Go, C und C++

Konfiguriert:

- Go LSP: `gopls`
- Go Formatter: `gofmt`
- C/C++ LSP: `clangd`
- Treesitter Parser fuer `go`, `c`, `cpp`

Go wird in Conform mit `gofmt` unterstuetzt, aber Auto-Format on Save ist aktuell nur fuer Rust, Python und Java aktiv.

## Formatting

Formatting liegt in `lua/jannis/plugins/conform.lua`.

Formatter pro Filetype:

| Filetype | Formatter |
| --- | --- |
| `go` | `gofmt` |
| `java` | `google-java-format` |
| `javascript` | `prettier` |
| `lua` | `stylua` |
| `python` | `black` |
| `rust` | `rustfmt` |
| `sh` / `bash` / `zsh` | `shfmt` |
| `typescript` | `prettier` |

Mason installiert automatisch:

- `black`
- `google-java-format`
- `prettier`
- `rust-analyzer`
- `shellcheck`
- `shfmt`
- `stylua`

Auto-Format on Save ist nur fuer diese Filetypes aktiv:

- `rust`
- `python`
- `java`

Manuelles Formatieren geht mit `<leader>f`.

## Linting

Linting liegt in `lua/jannis/plugins/lint.lua`.

Aktuell konfiguriert:

| Filetype | Linter |
| --- | --- |
| `sh` | `shellcheck` |
| `bash` | `shellcheck` |
| `zsh` | `shellcheck` |

`nvim-lint` laeuft bei `BufReadPost`, `BufWritePost` und `InsertLeave`. Manuelles Linting geht mit `<leader>ll`.

## Completion

Completion nutzt `nvim-cmp`.

Sources:

- `nvim_lsp`
- `luasnip`
- `buffer`

Completion-Fenster:

- Completion und Dokumentation haben Borders und transparente Hintergruende.
- Completion-Fenster: Max Height 12, dynamisch begrenzte Eintragsbreite.
- Dokumentations-Fenster: dynamische Max Height und Max Width anhand der aktuellen Editor-Groesse.
- Die aktive Completion-Auswahl bleibt als ganze Zeile gehighlighted.
- Die Dokumentation wird seitlich neben der Completion platziert; die Completion liegt im Z-Index hoeher, damit Docs die aktuelle Auswahl nicht verdecken.
- Die Dokumentation kann im Completion-Menue mit `<C-f>` nach unten und `<C-b>` nach oben gescrollt werden.
- Hover und Signature Help erscheinen ebenfalls in grossen rounded Floats.
- Icons/Text kommen ueber `lspkind`.

## Diagnostics

Diagnostics sind bewusst auf Errors fokussiert:

- Virtual Text zeigt nur Errors.
- Signs zeigen nur Errors.
- Underlines zeigen nur Errors.
- `<leader>e` oeffnet einen nicht fokussierbaren Error-Float fuer die aktuelle Zeile.
- `update_in_insert = false`, also werden Diagnostics nicht waehrend des Tippens staendig aktualisiert.
- Diagnostic-Floats haben rounded Border.
- Diagnostics werden nach Severity sortiert.

## Error-Workflow

Trouble zeigt Error-Uebersichten:

- `<leader>fe`: Errors im aktuellen File.
- `<leader>pe`: Errors im Projekt.

Trouble oeffnet rechts und bekommt den Fokus. `j`/`k` gehen durch die Error-Eintraege und zeigen jeweils die passende Code-Stelle als Preview im Hauptfenster. `Enter` springt final zum ausgewaehlten Error und schliesst die Liste.

## LSP-Keymaps

Siehe `keymaps.md`, Abschnitt `LSP`.
