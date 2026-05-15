# Themes

Das Theme-System liegt in `lua/jannis/theme.lua` und `lua/jannis/plugins/themes.lua`.

## Bedienung

- `<C-t>`: Theme Picker oeffnen.
- `:Theme`: Theme Picker oeffnen.

Der Picker nutzt Telescope. Falls Telescope nicht geladen werden kann, faellt er auf `vim.ui.select` zurueck.

## Default und Persistenz

- Default Theme: `ayu`
- Das aktive Neovim-Theme steht in `~/.config/jannis/themes.conf` unter `nvim_theme`.
- Zusaetzlich wird das zuletzt gewaehlte Theme kompatibel in `stdpath("state") .. "/jannis-theme"` gespeichert.
- Beim Start liest Neovim zuerst `nvim_theme`, danach den lokalen State und faellt dann auf `ayu` zurueck.

## Unabhaengige Programm-Themes

`~/.config/jannis/themes.conf` ist eine zentrale manuelle Uebersicht:

- `nvim_theme`
- `ghostty_theme`
- `rofi_theme`
- `waybar_theme`
- `wlogout_theme`

Ein Neovim-Themewechsel ueber `<C-t>` oder `:Theme` aktualisiert ausschliesslich `nvim_theme`. Ghostty, Rofi, Waybar und Wlogout werden dadurch nicht geaendert.

## Favoriten

Favoriten stehen im Theme Picker oben und sind mit `*` markiert.

Aktuelle Favoriten:

- `ayu`
- `rose-pine-moon`
- `catppuccin-mocha`
- `tokyonight-moon`
- `kanagawa-wave`
- `nightfox`
- `gruvbox-material`
- `melange`
- `bamboo`
- `github_dark_default`

Favoriten aenderst du in `lua/jannis/theme.lua` in `M.favorites`.

## Lazy Loading

Alle externen Theme-Plugins sind `lazy = true`. Beim Start wird nur das aktive Theme-Plugin geladen. Wenn du im Picker ein anderes Theme auswaehlst, wird das passende Plugin on demand geladen.

Die Zuordnung passiert in `plugin_by_colorscheme` und `plugin_prefixes`.

## Float- und Border-Fixes

`M.apply_float_highlights()` setzt nach jedem Theme-Wechsel Highlights fuer:

- `NormalFloat`
- `FloatBorder`
- `FloatTitle`
- `LineNr`
- `CursorLineNr`
- `LspInfoBorder`
- `Pmenu`
- `PmenuSel`
- `PmenuSbar`
- `PmenuThumb`
- `CmpNormal`
- `CmpBorder`
- `CmpSel`
- `CmpDocNormal`
- `CmpDocBorder`
- `CmpDocumentation`
- `CmpDocumentationBorder`
- `NeoTreeNormal`
- `NeoTreeNormalNC`
- `NeoTreeFloatNormal`
- `NeoTreeFloatBorder`
- `NeoTreeIndentMarker`
- `NeoTreeExpander`
- Diagnostic-Floating-Gruppen
- Telescope-Floating-Gruppen
- Dressing-Floating-Gruppen
- Lazy-, Mason-, WhichKey- und Notify-Floating-Gruppen

Ziel: Hover-Docs, Completion-Doku und andere Floating Windows sollen bei allen Themes transparente Hintergruende und lesbare Borders haben. Die Completion- und Pmenu-Auswahl (`CmpSel`, `PmenuSel`) ist die Ausnahme: Sie bekommt einen eigenen Hintergrund, damit der aktuell ausgewaehlte Eintrag sichtbar bleibt.

## LSP-Float-Konfiguration

In `theme.lua` werden die LSP Handler ueberschrieben:

- Hover (`K`, `<C-k>`) bekommt rounded Border, max width 100, max height 26.
- Signature Help (`<C-h>`) bekommt rounded Border, max width 100, max height 18.

## Theme-Plugins

Alle folgenden Theme-Plugins sind vorhanden:

- `projekt0n/github-nvim-theme` als `github-theme`
- `Shatur/neovim-ayu`
- `embark-theme/vim`
- `erikbackman/brightburn.vim`
- `catppuccin/nvim`
- `folke/tokyonight.nvim`
- `ellisonleao/gruvbox.nvim`
- `rose-pine/neovim`
- `rebelot/kanagawa.nvim`
- `EdenEast/nightfox.nvim`
- `navarasu/onedark.nvim`
- `sainnhe/everforest`
- `Mofiqul/dracula.nvim`
- `shaunsingh/nord.nvim`
- `Mofiqul/vscode.nvim`
- `sainnhe/gruvbox-material`
- `sainnhe/sonokai`
- `sainnhe/edge`
- `savq/melange-nvim`
- `marko-cerovac/material.nvim`
- `ribru17/bamboo.nvim`
- `rmehri01/onenord.nvim`
- `nyoom-engineering/oxocarbon.nvim`
- `AlexvZyl/nordic.nvim`
- `dasupradyumna/midnight.nvim`
- `olivercederborg/poimandres.nvim`
- `bluz71/vim-moonfly-colors`
- `bluz71/vim-nightfly-colors`
- `challenger-deep-theme/vim`
- `arzg/vim-colors-xcode`
- `tomasiser/vim-code-dark`
- `ramojus/mellifluous.nvim`
- `rktjmp/lush.nvim`
- `mcchrish/zenbones.nvim`

## Transparenz

Viele Themes sind auf transparente Hintergruende konfiguriert:

- GitHub Theme: `transparent = true`
- Catppuccin: `transparent_background = true`
- Tokyonight: `transparent = true`
- Gruvbox: `transparent_mode = true`
- Rose Pine: `disable_background = true`, `transparency = true`
- Kanagawa: `transparent = true`
- Nightfox: `transparent = true`
- Onedark: `transparent = true`
- Everforest: `transparent_background = 1`
- Dracula: `transparent_bg = true`
- Nord: `nord_disable_background = true`
- VSCode: `transparent = true`
- Gruvbox Material: `transparent_background = 1`
- Sonokai: `transparent_background = 1`
- Edge: `transparent_background = 1`
- Material: background disabled
- Bamboo: `transparent = true`
- Onenord: background disabled
- Nordic: `transparent = true`
- Poimandres: background disabled
- Moonfly/Nightfly: transparent globals
- Mellifluous: transparent background enabled
- Zenbones: transparent background enabled

## Verfuegbare Colorschemes im Picker

Die Liste steht in `M.themes` in `theme.lua`. Sie enthaelt externe Theme-Varianten und Neovim-Builtins, z. B.:

- Ayu, Ayu Dark, Ayu Mirage, Ayu Light
- Rose Pine Main/Moon/Dawn
- Catppuccin Mocha/Macchiato/Frappe/Latte
- Tokyonight Night/Storm/Moon/Day
- GitHub Dark/Light Varianten
- Kanagawa Wave/Dragon/Lotus
- Nightfox, Dayfox, Dawnfox, Duskfox, Nordfox, Terafox, Carbonfox
- Gruvbox, Gruvbox Material
- Dracula, Nord, VS Code Dark, Everforest, Sonokai, Edge
- Melange, Material, Bamboo, Onenord, Oxocarbon, Nordic
- Midnight, Poimandres, Moonfly, Nightfly, Challenger Deep
- Xcode Dark, Code Dark, Mellifluous
- Zenbones Varianten
- Neovim Builtins wie Habamax, Retrobox, Wildcharm, Desert, Evening, Slate, Torte, Industry, Lunaperche, Quiet
