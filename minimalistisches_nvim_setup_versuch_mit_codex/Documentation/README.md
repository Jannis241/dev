# Neovim Config Documentation

Diese Config ist bewusst Vim-nahe gehalten: Oil statt Neo-tree, native Statusline, Quickfix/Location List fuer Diagnostics, manuelle Completion-Dokumentation und command-basierter Theme-Wechsel.

## Wichtige Dateien

- `init.lua`: Einstieg und `.h` als C-Filetype.
- `lua/jannis/set.lua`: Optionen, englische Messages, Blockcursor, Rustacean-Grundsettings.
- `lua/jannis/terminal.lua`: `:Term`, `:Run`, `:RunFile` und Terminal-Keymaps.
- `lua/jannis/theme.lua`: `:Theme <colorscheme>` ohne Picker.
- `lua/jannis/plugins/`: Lazy-Plugin-Specs.

## Wichtige Commands

- `:Theme vim`: Vim-artiges Default-Theme setzen.
- `:Theme default`: Neovim-Default-Theme setzen.
- `:Term [cmd]`: Terminal unten oeffnen.
- `:Run <cmd>`: Shell-Command im Terminal-Split ausfuehren.
- `:RunFile`: Aktuelle Datei ausfuehren.
- `:Git`: Fugitive Git-Status.
