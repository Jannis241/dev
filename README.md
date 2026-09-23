# Dotfiles / Dev Environment

Persoenliche Dotfiles fuer ein Arch/Hyprland-Setup mit Zsh, Neovim, Ghostty, Waybar, Rofi und eigenen Helper-Skripten.

## Struktur

- `env/`: Home-Overlay, das durch `dev-env` nach `$HOME` kopiert wird.
- `env/.config/`: App-Konfigurationen fuer `nvim`, `hypr`, `waybar`, `rofi`, `ghostty`, `wlogout` usw.
- `env/.local/scripts/`: Eigene Skripte wie `dev-env`, `dev-doctor`, `fix-paru`, `get-dependencies`, `update_script`, `jnew`, `jrun`, `search`.
- `env/.zshenv`, `env/.zprofile`, `env/.zshrc`, `env/.profile`: Shell- und PATH-Setup.
- `dependencies/`: Paketlisten fuer Pacman, AUR und Flatpak.
- `dev-env`: Kopiert die Dotfiles aus `env/` ins Home-Verzeichnis.
- `dotfiles_setup`: Installiert Pakete, aktiviert Dienste und fuehrt `dev-env` aus.
- `wallpaper.png`: Desktop-Wallpaper.

## Von normalem Arch zu diesem Setup

Auf einem bereits installierten Arch-System als normaler User:

```bash
sudo pacman -Syu --needed git base-devel
git clone https://github.com/Jannis241/dev.git "$HOME/dev"
cd "$HOME/dev"
./dotfiles_setup
```

Trockenlauf ohne Aenderungen:

```bash
./dotfiles_setup --dry-run
```

Nichtinteraktiver Lauf, soweit die Paketmanager das zulassen:

```bash
./dotfiles_setup --yes
```

Nuetzliche Optionen:

- `--no-packages`: Pacman-Pakete ueberspringen.
- `--no-aur`: Paru/AUR ueberspringen.
- `--no-flatpak`: Flatpak ueberspringen.
- `--no-dotfiles`: Dotfiles nicht kopieren.
- `--no-services`: `NetworkManager` und `sddm` nicht aktivieren.
- `--no-shell`: Login-Shell nicht auf Zsh setzen.

Nach dem Setup einmal neu einloggen oder `exec zsh` ausfuehren.

## Dotfiles manuell anwenden

`dev-env` nutzt standardmaessig das aktuelle Repo als `DEV_ENV`, wenn es direkt aus dem Repo gestartet wird. Nach der Installation setzt `.zshenv` `DEV_ENV="$HOME/dev"`.

```bash
cd "$HOME/dev"
./dev-env --dry
./dev-env
```

`dev-env` kopiert:

- `env/.config/*` nach `${XDG_CONFIG_HOME:-$HOME/.config}`
- `env/.local/*` nach `$HOME/.local`
- Shell-Dateien nach `$HOME`
- `dev-env` nach `$HOME/.local/scripts/dev-env`
- `wallpaper.png` nach `$HOME/wallpaper.png`

Bestehende Zielpfade werden dabei ersetzt. Lokale, host-spezifische Anpassungen gehoeren deshalb nicht direkt in die synchronisierten Dateien.

## Themes

Themes werden nicht zentral gekoppelt. Aendere das Theme direkt in der Config des jeweiligen Programms:

- Neovim: `<C-t>` oder `:Theme`; gespeichert wird in `stdpath("state") .. "/jannis-theme"`
- Ghostty: `~/.config/ghostty/config`
- Rofi: `~/.config/colors/colors.rasi` und `~/.config/rofi/config.rasi`
- Waybar: `~/.config/colors/colors.css` und `~/.config/waybar/style.css`
- Wlogout: `~/.config/wlogout/colors.css`

## Hyprland

`env/.config/hypr/hyprland.conf` ist der Einstiegspunkt und sourced:

- `custom_settings.conf`: Programme, Monitorlayout, Workspace-Zuordnung und Tastaturlayout; das ist die Datei, die du auf neuer Hardware zuerst anpasst.
- `env.conf`
- `autostart.conf`
- `look.conf`
- `input.conf`
- `workspaces.conf`
- `binds.conf`
- `windowrules.conf`

Alles liegt im Repo unter `env/.config/hypr`. Nach Aenderungen kopiert `dev-env` die komplette Hyprland-Config nach `~/.config/hypr`.

## Skripte

- `dev-doctor`: Prueft wichtige Tools, Sync-Status, `paru`, Oh My Zsh, Hyprland-Custom-Settings und ob Neovim headless laedt.
- `fix-paru`: Baut `paru` neu gegen die aktuelle Pacman/`libalpm`-Version.
- `get-dependencies`: Ueberschreibt die Paketlisten mit dem aktuellen Systemzustand plus Pflichtpaketen.
- `update_script`: Aktualisiert System, AUR, Flatpak, Rust und optional Oh My Zsh; Cleanup ist separat.

## Manuelle Anpassungen

Diese Punkte kann das Repo nicht sicher automatisch wissen:

- Monitor-Namen und Layouts (`hyprctl monitors`, dann `env/.config/hypr/custom_settings.conf` anpassen).
- Hostname, Git-Identitaet und SSH-Keys.
- Hardware-spezifische Pakete wie `nvidia-open`, `amd-ucode`, CUDA oder Drucker/Bluetooth-Setup.
- Private Pfade, Tokens, AI-Tool-Konfigurationen und echte SSH-Notizen.
- Ob `sddm` als Display Manager gewuenscht ist.

## Pakete

Die Paketlisten liegen in `dependencies/`:

- `base.txt`: Basissystem, Shell, Netzwerk, Paketmanagement.
- `desktop.txt`: Hyprland, Wayland, Audio, UI-Tools.
- `dev.txt`: Editor, Toolchains, Linter, Formatter, CLI-Helfer.
- `fonts.txt`: Fonts.
- `apps.txt`: Anwendungen und hardware-nahe Pakete.
- `aur.txt`: AUR-Pakete.
- `flatpak.txt`: Flatpak-Apps.
- `pacman.txt` und `paru.txt`: Kompatibilitaets-Aggregate.

Manuell:

```bash
sudo pacman -S --needed - < dependencies/base.txt
sudo pacman -S --needed - < dependencies/desktop.txt
sudo pacman -S --needed - < dependencies/dev.txt
sudo pacman -S --needed - < dependencies/fonts.txt
sudo pacman -S --needed - < dependencies/apps.txt
paru -S --needed - < dependencies/aur.txt
xargs -a dependencies/flatpak.txt -r flatpak install -y flathub
```

## Checks

```bash
command -v nvim hyprland waybar rofi ghostty paru
command -v rg shellcheck shfmt stylua
ls -la ~/.config ~/.local/scripts
hyprctl monitors
```

Neovim installiert Plugins beim ersten Start ueber `lazy.nvim`, falls sie noch fehlen.
