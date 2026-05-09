# Neovim Config Documentation

Diese Dokumentation beschreibt die komplette Config unter `env/.config/nvim`.
Der Einstiegspunkt ist `init.lua`, der nur `require("jannis")` ausfuehrt. Die eigentliche Config liegt in `lua/jannis`.

## Dateien

- `init.lua`: Minimaler Einstiegspunkt fuer Neovim.
- `lua/jannis/init.lua`: Bootstrap fuer `lazy.nvim`, globale Autocommands, LSP-Keymaps und Plugin-Setup.
- `lua/jannis/set.lua`: Editor-Optionen, Undo, Suche, Einrueckung, Zeilennummern und Rustacean-Grundsettings.
- `lua/jannis/remap.lua`: Globale Keymaps, die nicht direkt zu einem Plugin gehoeren.
- `lua/jannis/theme.lua`: Theme-System mit Telescope-Auswahl, Favoriten, Persistenz und Float-Highlight-Fixes.
- `lua/jannis/plugins/*.lua`: Lazy-Plugin-Specs. Jede Datei beschreibt ein Plugin oder eine Plugin-Gruppe.
- `lazy-lock.json`: Lockfile mit festen Plugin-Commits.

## Dokumentationsdateien

- `structure.md`: Aufbau, Lade-Reihenfolge und zentrale Konzepte.
- `keymaps.md`: Alle eigenen Keybinds aus der Config.
- `plugins.md`: Jedes Plugin mit Zweck, Lazy-Loading und wichtigen Features.
- `lsp-formatting-diagnostics.md`: LSP, Completion, Diagnostics, Formatting und Sprachsupport.
- `themes.md`: Theme-System, Favoriten, transparente Hintergruende und Theme-Plugins.
- `default-neovim-keybinds.md`: Sinnvolle Default-Vim/Neovim-Keybinds, die man kennen sollte.

## Grundidee

Die Config ist auf schnelles Starten und spaeteres Nachladen ausgelegt:

- Themes werden lazy geladen. Nur das aktive Theme wird beim Start geladen.
- Rust wird ueber `rustaceanvim` behandelt, nicht noch einmal ueber `mason-lspconfig`.
- Diagnostics zeigen im normalen Code nur Errors prominent an.
- Trouble dient als Error-Uebersicht fuer File oder Projekt.
- Telescope ist die zentrale Such-/Picker-Oberflaeche.
- Conform formatiert Rust, Python und Java automatisch beim Speichern.

## Wichtige Commands

- `:Lazy`: Plugin-Manager oeffnen.
- `:Mason`: LSP-Server und Tools verwalten.
- `:Theme`: Theme-Auswahl oeffnen.
- `:Neotree`: File-Tree oeffnen.
- `:PeekOpen` / `:PeekClose`: Markdown-Preview steuern, falls `deno` installiert ist.

