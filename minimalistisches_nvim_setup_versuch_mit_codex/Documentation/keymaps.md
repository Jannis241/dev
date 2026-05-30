# Keymaps

`<leader>` ist Space.

## Dateien und Suche

| Key | Aktion |
| --- | --- |
| `-` | Oil oeffnen |
| `<leader>pv` | Oil File Browser oeffnen |
| `<leader>pf` | Telescope Find Files |
| `<leader>ps` | Telescope Live Grep |
| `<leader>pws` | Im aktuellen Buffer suchen |
| `<leader>fb` | Buffer suchen |
| `<leader>fh` | Help Tags suchen |

## Terminal und Ausfuehren

| Key/Command | Aktion |
| --- | --- |
| `<leader>tt` | Terminal unten oeffnen |
| `<leader>tr` | Aktuelle Datei ausfuehren |
| `:Term [cmd]` | Terminal-Split oeffnen, optional mit Command |
| `:Run <cmd>` | Shell-Command im Terminal-Split ausfuehren |
| `:RunFile` | Aktuelle Datei ausfuehren |
| `<Esc>` im Terminal | Terminal-Mode verlassen |

`RunFile` kennt Python, Shell, Lua, C, C++, Rust und Java. Fuer Rust nutzt es `cargo run`, wenn ein `Cargo.toml` gefunden wird.

## LSP und Diagnostics

| Key | Aktion |
| --- | --- |
| `K` | Hover-Dokumentation |
| `<leader>gd` | Go to Definition |
| `<leader>vca` | Code Action |
| `<leader>rn` | Rename |
| `<leader>e` | Diagnostic-Float |
| `<leader>fe` | File-Diagnostics in Location List |
| `<leader>pe` | Projekt-Diagnostics in Quickfix |

## Completion

| Key | Aktion |
| --- | --- |
| `<C-n>` | Naechster Eintrag |
| `<C-p>` | Vorheriger Eintrag |
| `<C-y>` | Bestaetigen |
| `<C-e>` | Abbrechen |
| `<C-Space>` | Completion manuell oeffnen |
| `<C-f>` | Docs oeffnen/scrollen |
| `<C-b>` | Docs hochscrollen |
