# Dotfiles / Dev Environment

Persönliche Dotfiles, Shell-Konfigurationen und Utility-Skripte für ein Linux-Setup (primär Arch/Hyprland).

## Struktur

- `env/`: Inhalte, die in das Home-Verzeichnis synchronisiert werden.
  - `env/.config/`: App-Konfigurationen (z. B. `nvim`, `hypr`, `waybar`, `rofi`, `ghostty`, `wlogout`)
  - `env/.local/scripts/`: Eigene Shell-Helfer
  - `env/.zshrc`, `env/.zsh_profile`, `env/.profile`: Shell-Setup
- `dev-env`: Sync-Skript, das Dateien aus diesem Repo nach `$HOME` kopiert.
- `dependencies/`: Exportierte Paketlisten (`pacman`, `paru`, `flatpak`).
- `wallpaper.png`: Desktop-Wallpaper.
- `ssh.txt`: SSH-Notizen.

## Voraussetzungen

- Linux-System (Arch-basiert empfohlen)
- `bash`, `find`, `cp`, `rm`
- Optional je nach Skript: `pacman`, `paru`, `flatpak`, `snap`, `rustup`, `fd`, `jq`, `rofi`

## Setup

`DEV_ENV` muss auf dieses Repo zeigen:

```bash
export DEV_ENV="$HOME/dev"
```

Optional dauerhaft in der Shell setzen (z. B. in `~/.zshrc`).

## Dotfiles anwenden

Trockenlauf:

```bash
./dev-env --dry
```

Anwenden:

```bash
./dev-env
```

Was passiert:

- Inhalte aus `env/.config` nach `$XDG_CONFIG_HOME` (fallback `~/.config`)
- Inhalte aus `env/.local` nach `~/.local`
- Einzeldateien wie `~/.zshrc`, `~/.zsh_profile`, `~/.profile`
- `dev-env` nach `~/.local/scripts/dev-env`
- `wallpaper.png` nach `~/wallpaper.png`

## Skripte (`env/.local/scripts`)

- `cmt`: `git add -A`, Commit mit Message, dann `pull --rebase` und `push`
- `dev-git`: führt `update_script` und `get-dependencies` aus, committed/pusht anschließend dieses Repo
- `get-dependencies`: exportiert installierte Pakete nach `dependencies/`
- `jnew`: erstellt Java-Projektgerüst (`src/Main.java`)
- `jrun`: kompiliert und startet eine Java-Datei (`fd`-basiert)
- `search`: öffnet Browser-Suche (optional via `rofi` Prompt)
- `update_script`: System-Update/Cleanup (paketmanager- und cache-lastig, teils mit `sudo`)

## Paketlisten wiederherstellen (manuell)

```bash
sudo pacman -S --needed - < dependencies/pacman.txt
paru -S --needed - < dependencies/paru.txt
xargs -a dependencies/flatpak.txt -r flatpak install -y flathub
```

## Hinweise

- `dev-env` überschreibt Zielinhalte bewusst (vorher ggf. Backups machen).
- Einige Skripte sind absichtlich "aggressiv" (z. B. Cleanup). Vor Nutzung prüfen.
