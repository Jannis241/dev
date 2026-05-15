# Dotfiles / Dev Environment

Persönliche Dotfiles, Shell-Konfigurationen und Utility-Skripte für ein Linux-Setup (primär Arch/Hyprland).

## Struktur

- `env/`: Inhalte, die in das Home-Verzeichnis synchronisiert werden.
  - `env/.config/`: App-Konfigurationen (z. B. `nvim`, `hypr`, `waybar`, `rofi`, `ghostty`, `wlogout`)
  - `env/.local/scripts/`: Eigene Shell-Helfer
  - `env/.zshenv`, `env/.zprofile`, `env/.zshrc`, `env/.profile`: Shell-Setup
- `dev-env`: Sync-Skript, das Dateien aus diesem Repo nach `$HOME` kopiert.
- `dependencies/`: Exportierte Paketlisten, aufgeteilt in `base`, `desktop`, `dev`, `fonts`, `apps`, `aur` und `flatpak`.
- `wallpaper.png`: Desktop-Wallpaper.
- `ssh.example.txt`: Template fuer SSH-Notizen ohne private Daten.

## Voraussetzungen

- Linux-System (Arch-basiert empfohlen)
- `bash`, `find`, `cp`, `rm`
- Optional je nach Skript: `pacman`, `paru`, `flatpak`, `rustup`, `fd`, `jq`, `rofi`, `fzf`

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
- Einzeldateien wie `~/.zshenv`, `~/.zprofile`, `~/.zshrc`, `~/.profile`
- `dev-env` nach `~/.local/scripts/dev-env`
- `wallpaper.png` nach `~/wallpaper.png`
- `~/.config/hypr-host.conf` wird angelegt, falls es noch fehlt. Diese Datei bleibt ausserhalb des synchronisierten Hyprland-Ordners und ist fuer host-spezifische Monitor-/Workspace-Overrides gedacht.
- `theme-switch --current --quiet` regeneriert nach dem Sync die gemeinsamen Theme-Dateien fuer Waybar, Rofi, Wlogout, Ghostty und Neovim.
- Hyprland wird neu geladen und Waybar sowie Hyprpaper werden nach dem Sync neu gestartet, damit das Desktop-Setup aktiv bleibt.

## Skripte (`env/.local/scripts`)

- `cmt`: `git add -A`, Commit mit Message, dann `pull --rebase` und `push`
- `dev-git`: führt `update_script` und `get-dependencies` aus, committed/pusht anschließend dieses Repo
- `get-dependencies`: exportiert native Pakete mit `pacman -Qqen`, AUR-Pakete mit `pacman -Qqem` und schreibt Kategorien nach `dependencies/`
- `jnew`: erstellt Java-Projektgerüst (`src/Main.java`)
- `jrun`: kompiliert und startet eine Java-Datei (`fd`-basiert)
- `search`: öffnet Browser-Suche (optional via `rofi` Prompt)
- `theme-switch`: gemeinsamer Theme-Switcher fuer `colors.css`, `colors.rasi`, Ghostty, Wlogout und Neovim-State
- `update_script`: vorsichtiges System-Update/Cleanup mit Modi `update`, `cleanup`, `full`, `--dry-run` und `--yes`

## Paketlisten wiederherstellen (manuell)

```bash
sudo pacman -S --needed - < dependencies/base.txt
sudo pacman -S --needed - < dependencies/desktop.txt
sudo pacman -S --needed - < dependencies/dev.txt
sudo pacman -S --needed - < dependencies/fonts.txt
sudo pacman -S --needed - < dependencies/apps.txt
paru -S --needed - < dependencies/aur.txt
xargs -a dependencies/flatpak.txt -r flatpak install -y flathub
```

## Hyprland-Struktur

`env/.config/hypr/hyprland.conf` ist nur noch ein Einstiegspunkt und sourced:

- `programs.conf`: Terminal, Dateimanager, Launcher
- `env.conf`: Session-Umgebungsvariablen
- `monitors.conf`: Default-Monitorlayout
- `autostart.conf`: Autostart-Programme
- `look.conf`: Gaps, Blur, Animationen, Layout
- `input.conf`: Tastatur, Maus, Touchpad
- `workspaces.conf`: Workspace-Zuordnung
- `binds.conf`: Tastenkombinationen
- `windowrules.conf`: Window Rules

Host-spezifische Anpassungen gehoeren nach `~/.config/hypr-host.conf`. `dev-env` legt diese Datei an, ueberschreibt sie aber nicht.

## Gemeinsames Theme

Die Theme-Daten stehen in `env/.config/theme-switcher/themes.tsv`. Anwenden:

```bash
theme-switch ayu
theme-switch catppuccin-mocha
theme-switch --list
```

Der Switcher generiert `colors.css`, `colors.rasi`, `wlogout/colors.css`, `ghostty/theme.conf` und den Neovim-State. In Neovim aktualisiert `:Theme` bzw. `<C-t>` ebenfalls die externen Theme-Dateien, sofern `theme-switch` im `PATH` liegt.

## Hinweise

- `dev-env` überschreibt Zielinhalte bewusst (vorher ggf. Backups machen).
- `dependencies/pacman.txt` und `dependencies/paru.txt` bleiben als Kompatibilitaets-Aggregate erhalten. Die kategorisierten Listen sind die bevorzugte Quelle.
- Meslo wird ueber `dependencies/aur.txt` als `ttf-meslo` installiert; lokale AUR-/Build-Verzeichnisse gehoeren nicht in `env/.config/ghostty`.
- Logs, lokale AI-Tool-Konfigurationen und echte SSH-Notizen bleiben ungetrackt. Nutze `ssh.example.txt` als Vorlage.
- Die Zsh-Konfiguration ist plain Zsh. `zsh-autosuggestions` und `zsh-syntax-highlighting` werden genutzt, wenn die Pakete installiert sind; Oh My Zsh ist nicht mehr erforderlich.

## Komplette Neuinstallation (Arch) - Schritt für Schritt

Diese Anleitung ist als reproduzierbarer Ablauf gedacht, um ein frisches Arch-System aufzusetzen und danach dieses Repo 1:1 wieder einzuspielen.

### 0) Vorbereitung

- Aktuelles Arch-ISO laden und bootfähigen USB-Stick erstellen.
- BIOS/UEFI prüfen:
  - UEFI aktivieren
  - Secure Boot deaktivieren (falls nicht extra konfiguriert)
- Netzwerk bereitstellen (LAN oder WLAN-Zugangsdaten).
- Ziel-Disk und gewünschtes Partitionslayout vorher festlegen.

### 1) Arch-Installation vom Live-ISO

#### 1.1 Tastatur, Uhrzeit, Netzwerk

```bash
loadkeys de-latin1
timedatectl set-ntp true
ping -c 3 archlinux.org
```

Für WLAN (falls nötig):

```bash
iwctl
# innerhalb iwctl:
# device list
# station <wlan-interface> scan
# station <wlan-interface> get-networks
# station <wlan-interface> connect "<SSID>"
# exit
```

#### 1.2 Partitionieren (UEFI-Beispiel)

Beispiel-Disk: `/dev/nvme0n1`
Beispiel-Layout:
- EFI: 1 GiB (`/dev/nvme0n1p1`)
- Root: Rest (`/dev/nvme0n1p2`)

```bash
cfdisk /dev/nvme0n1
```

#### 1.3 Formatieren und Mounten

```bash
mkfs.fat -F32 /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p2

mount /dev/nvme0n1p2 /mnt
mkdir -p /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot
```

#### 1.4 Basissystem installieren

```bash
pacstrap -K /mnt base linux linux-firmware base-devel git zsh networkmanager sudo
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
```

#### 1.5 Systemgrundkonfiguration (im Chroot)

```bash
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

sed -i 's/^#de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=de_DE.UTF-8" > /etc/locale.conf

echo "arch" > /etc/hostname
```

Hosts-Datei:

```bash
cat > /etc/hosts <<'EOF'
127.0.0.1 localhost
::1       localhost
127.0.1.1 arch.localdomain arch
EOF
```

Root-Passwort setzen:

```bash
passwd
```

#### 1.6 Bootloader (systemd-boot, UEFI)

```bash
bootctl install
```

Kernel-UUID ermitteln:

```bash
blkid /dev/nvme0n1p2
```

Loader konfigurieren:

```bash
cat > /boot/loader/loader.conf <<'EOF'
default arch
timeout 3
editor no
EOF
```

`<ROOT_UUID>` ersetzen:

```bash
cat > /boot/loader/entries/arch.conf <<'EOF'
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=UUID=<ROOT_UUID> rw
EOF
```

#### 1.7 User anlegen und sudo aktivieren

```bash
useradd -m -G wheel -s /bin/zsh jannis
passwd jannis
EDITOR=vi visudo
```

In `visudo` Zeile aktivieren:

```text
%wheel ALL=(ALL:ALL) ALL
```

#### 1.8 Dienste aktivieren und Reboot

```bash
systemctl enable NetworkManager
exit
umount -R /mnt
reboot
```

### 2) Nach dem ersten Boot

Als normaler User anmelden und Basis-Tools installieren:

```bash
sudo pacman -Syu --needed git base-devel
```

Repo klonen (Pfad wie im README erwartet):

```bash
mkdir -p "$HOME/dev"
cd "$HOME/dev"
git clone https://github.com/Jannis241/dev.git .
```

`DEV_ENV` setzen:

```bash
echo 'export DEV_ENV="$HOME/dev"' >> ~/.zshrc
export DEV_ENV="$HOME/dev"
```

### 3) Paketlisten wiederherstellen

Pacman-Pakete:

```bash
sudo pacman -S --needed - < dependencies/base.txt
sudo pacman -S --needed - < dependencies/desktop.txt
sudo pacman -S --needed - < dependencies/dev.txt
sudo pacman -S --needed - < dependencies/fonts.txt
sudo pacman -S --needed - < dependencies/apps.txt
```

Paru installieren (falls noch nicht vorhanden):

```bash
cd /tmp
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

AUR-Pakete:

```bash
cd "$DEV_ENV"
paru -S --needed - < dependencies/aur.txt
```

Flatpak (falls genutzt):

```bash
sudo pacman -S --needed flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
xargs -a dependencies/flatpak.txt -r flatpak install -y flathub
```

### 4) Dotfiles und Skripte einspielen

Vorab Testlauf:

```bash
cd "$DEV_ENV"
./dev-env --dry
```

Dann anwenden:

```bash
./dev-env
```

Neue Shell laden:

```bash
exec zsh
```

### 5) Perfekt-funktionierende Installation: Checkliste

- Login-Shell ist `zsh`:
```bash
echo $SHELL
```
- Wichtige Tools vorhanden:
```bash
command -v nvim hyprland waybar rofi ghostty flatpak paru
command -v theme-switch rg shellcheck shfmt
```
- Dotfiles liegen am Ziel:
```bash
ls -la ~/.config ~/.local/scripts
```
- Eigene Skripte ausführbar:
```bash
ls -l ~/.local/scripts
```
- Wallpaper vorhanden:
```bash
ls -l ~/wallpaper.png
```
- Optionaler finaler System-Update-Lauf:
```bash
sudo pacman -Syu
paru -Syu
flatpak update -y
```

### 6) Optional, aber sinnvoll

- SSH-Key neu erstellen und in Git-Host hinterlegen:
```bash
ssh-keygen -t ed25519 -C "you@example.com"
cat ~/.ssh/id_ed25519.pub
```
- Git-Identität setzen:
```bash
git config --global user.name "Dein Name"
git config --global user.email "you@example.com"
```
- Audio/Bluetooth/Printing nur bei Bedarf nachinstallieren.
- Vor produktiver Nutzung einmal Reboot durchführen und kompletten Workflow testen.
