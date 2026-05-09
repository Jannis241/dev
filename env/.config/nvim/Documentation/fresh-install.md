# Fresh Install

Diese Config kann sich ab dem Punkt selbst einrichten, an dem Neovim die Config lesen und `git` benutzen kann.

## Was automatisch passiert

- `lazy.nvim` wird automatisch nach `stdpath("data") .. "/lazy/lazy.nvim"` geklont, falls es fehlt.
- Fehlende Plugins werden automatisch installiert.
- Lazy macht keine Update-Checks beim normalen Start.
- LSP/Completion/Mason laden erst beim Oeffnen einer Datei.
- Mason installiert konfigurierte LSP-Server und Tools auf interaktiven Neovim-Starts, sofern die benoetigten System-Provider vorhanden sind. In Headless/CI wird diese automatische Installation nicht gestartet.
- Treesitter installiert nur fehlende Parser.
- Theme-Plugins werden nur on demand geladen; beim Start wird nur das aktive Theme geladen.

## Was nicht komplett automatisch geht

Wenn auf einem Linux-System wirklich gar nichts installiert ist, kann Neovim nicht alle Abhaengigkeiten alleine beschaffen. Diese Dinge muessen ueber den Paketmanager oder deine Dotfiles-Installationslogik vorhanden sein:

- `neovim`
- `git`, sonst kann `lazy.nvim` nicht gebootstrapped werden
- `curl`, `unzip`, `tar`, `gzip`, weil Mason viele Pakete damit entpackt/laedt
- `ripgrep`, damit Telescope Live Grep (`<leader>ps`) funktioniert
- optional `fd`, damit Telescope Dateisuche schneller ist
- `make` und ein C/C++ Compiler fuer native Plugins und Treesitter Parser
- `python3`, weil Tools wie `black` Python brauchen
- `node`/`npm`, weil Tools wie `pyright` und `prettier` aus dem Node/NPM-Umfeld kommen
- Java Runtime, weil `jdtls` und `google-java-format` Java brauchen
- Rust via `rustup`, wenn Rust-Projekte inklusive `rustfmt` sauber funktionieren sollen

Ein separates `lua`-Paket ist nicht noetig. Neovim bringt Lua/LuaJIT fuer die Config selbst mit.

## Verhalten nach dem ersten Start

Nach dem ersten erfolgreichen Start sind Plugins, Mason-Pakete und Treesitter Parser lokal installiert. Danach werden sie nicht bei jedem Start neu installiert. Die Config bleibt schnell, weil schwere Teile lazy geladen werden:

- Telescope erst bei Telescope-Keys oder `:Telescope`
- LSP/Completion/Mason erst bei Datei-Buffern
- Neo-tree erst bei `:Neotree` oder den Filetree-Keys
- Trouble erst bei Error-/Quickfix-Keys
- Harpoon erst bei Harpoon-Keys
- PHP-Support nur bei PHP-Dateien
- Snippets erst im Insert Mode
- Lualine erst `VeryLazy`
