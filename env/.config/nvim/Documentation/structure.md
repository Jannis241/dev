# Struktur und Lade-Reihenfolge

## Einstieg

`env/.config/nvim/init.lua` enthaelt nur:

```lua
require("jannis")
```

Dadurch wird `lua/jannis/init.lua` geladen.

## `lua/jannis/init.lua`

Diese Datei macht die zentrale Initialisierung:

1. Setzt `<leader>` auf Space.
2. Bootstrapped `lazy.nvim`, falls es noch nicht installiert ist.
3. Laedt `jannis.set`.
4. Setzt einen Compatibility-Shim fuer `vim.lsp.get_buffers_by_client_id`.
5. Definiert Autocommands.
6. Definiert buffer-lokale LSP-Keymaps in `LspAttach` und den globalen Error-Float-Shortcut `<leader>e`.
7. Laedt alle Plugins mit `require("lazy").setup("jannis.plugins", opts)`.
8. Initialisiert das Theme-System mit `require("jannis.theme").setup()`.
9. Laedt globale Remaps aus `jannis.remap`.

## Fresh-Install-Verhalten

Die Config ist so ausgelegt, dass sie auf einem frischen Linux-PC nach dem Clonen selbst bootstrapped:

- `lazy.nvim` wird automatisch geklont, falls es fehlt.
- Fehlende Plugins werden durch Lazy automatisch installiert (`install.missing = true`).
- Lazy macht keine automatischen Update-Checks beim Start (`checker.enabled = false`), damit der normale Start schnell bleibt.
- Mason stellt die konfigurierten LSP-Server und Tools sicher.
- Mason LSP-/Tool-Installation laeuft nur bei interaktiven Starts, nicht in Headless/CI. Tools laufen verzögert und ohne Auto-Update; bereits installierte Tools werden nicht neu installiert. In Headless wird Mason/LSP-Autostart nicht gestartet, damit CI- oder Script-Aufrufe nicht versuchen, fehlende Server zu installieren oder zu starten.
- Treesitter installiert nur Parser, die lokal noch fehlen.

Nach dem ersten Start sind die Plugins, LSP-Server, Formatter und Parser lokal installiert. Danach bleibt der normale Start schnell, weil nichts neu installiert wird, solange nichts fehlt.

## System-Voraussetzungen

Neovim kann ueber Lazy und Mason viel selbst installieren, aber keine distro-spezifischen Systempakete ohne Paketmanager/root-Rechte. Auf einem neuen Linux-System sollten mindestens vorhanden sein:

- `git`
- `make` und ein C/C++ Compiler fuer native Builds und Treesitter Parser
- `curl`, `unzip`, `tar`, `gzip`
- `ripgrep` fuer Telescope Live Grep; optional `fd` fuer schnellere Dateisuche
- `python3`, weil Python-basierte Mason-Tools wie `black` eine Python-Laufzeit brauchen
- Java Runtime fuer `jdtls` und Java-Formatting
- Rust Toolchain via `rustup`, wenn Rust inklusive `rustfmt` genutzt werden soll
- Node/npm, falls Mason npm-basierte Tools wie `prettier` installieren soll

Nicht benoetigt ist ein separates `lua`-Paket: Neovim bringt die Lua/LuaJIT-Runtime fuer die Config selbst mit.

## Autocommands

- `BufWritePre *`: Entfernt trailing whitespace vor dem Speichern nur in normalen, editierbaren Buffern.
- `LspAttach`: Setzt buffer-lokale LSP-Keymaps, sobald ein LSP-Client an einen Buffer attached.
- `<leader>e` oeffnet den Error-Float fuer die aktuelle Zeile und bleibt ein vollstaendiges Mapping. Error-Listen liegen unter `<leader>fe` und `<leader>pe`.

## Filetypes

Die Extension `templ` wird als Filetype `templ` registriert. Treesitter hat dazu ebenfalls eine eigene Parser-Konfiguration.

## `lua/jannis/set.lua`

Diese Datei enthaelt Editor-Optionen:

- Absolute und relative Line Numbers sind aktiv.
- Tabs werden als 4 Spaces expandiert.
- Smartindent ist aktiv.
- Zeilenumbruch ist deaktiviert.
- Swapfile und Backup sind aus.
- Persistent Undo ist aktiv unter `~/.vim/undodir`.
- Suche: `hlsearch` aus, `incsearch` an.
- Truecolor ist aktiv.
- `scrolloff = 10`, damit beim Scrollen immer Kontext bleibt.
- `signcolumn = "yes"`, damit Diagnostic/Git-Zeichen die Textspalten nicht verschieben.
- `updatetime = 50`, damit UI-Reaktionen schneller sind.

## Rustacean-Grundsettings in `set.lua`

`vim.g.rustaceanvim` konfiguriert Rust Analyzer fuer `rustaceanvim`:

- `checkOnSave = true`
- Inlay Hints fuer Lifetimes, Parameter, Types und Chaining sind aktiv.
- `dap = {}` und `tools = {}` bleiben minimal.

Rust Analyzer wird absichtlich nicht ueber `mason-lspconfig` automatisch enabled, damit er nicht doppelt laeuft.

## `lua/jannis/remap.lua`

Globale Keymaps, die nicht direkt an einen Plugin-Spec gekoppelt sind. Plugin-spezifische Keymaps liegen ueberwiegend in den jeweiligen Plugin-Dateien. Prefix-Mappings werden vermieden, wenn sie haeufige normale Tasten verzoegern wuerden, zum Beispiel `p`.

## `lua/jannis/theme.lua`

Eigenes Theme-System:

- Default Theme: `ayu`
- Aktives Theme wird in `stdpath("state") .. "/jannis-theme"` gespeichert.
- Theme-Auswahl ueber Telescope oder fallback `vim.ui.select`.
- Favoriten stehen in der Auswahl oben.
- Float-/Border-Highlights werden nach jedem Theme-Wechsel neu gesetzt.
- Floating Windows bleiben dabei standardmaessig transparent; Completion/Pmenu markieren nur die aktive Auswahl mit eigenem Hintergrund.
- Sticky Treesitter Context bekommt einen dezenten Hintergrund und eine Unterkante, damit Methodensignaturen am oberen Fensterrand klar vom Code getrennt sind, ohne eine zweite Zeile zu belegen.

## `lua/jannis/plugins`

Lazy findet alle Plugin-Specs in diesem Ordner. Die Dateinamen sind organisatorisch:

- Manche Dateien enthalten genau ein Plugin.
- `fzf.lua` ist leer, weil `telescope-fzf-native.nvim` als Telescope-Dependency definiert ist.
- `harpoon.lua` konfiguriert schnelle Projekt-Navigation ueber Harpoon.
