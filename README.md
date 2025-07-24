# 🛠️ Dotfiles für Arch Linux mit Hyprland

Diese Dotfiles sind für ein Arch Linux Setup optimiert.
Wenn du meine Hyprland-spezifischen Einstellungen nutzen möchtest, sollte Hyprland installiert sein.

---

## ✅ Voraussetzungen

- Arch Linux (mit Internetzugang)
- Optional: Hyprland (für Hyprland-Konfigurationen)

---

## 📁 Dateistruktur

```bash
~/wallpaper.png       # Hintergrundbild
~/dev                 # Dotfiles- und Dev-Verzeichnis (dieses Repo)
~/.config             # Konfigurationsordner (Zielort der Konfigs)
~/programmieren       # Persönliches Programmierverzeichnis

## ⚙️ Konfiguration ändern

1. Bearbeite die gewünschten Konfigurationsdateien im Ordner:

   ```bash
   ~/dev/env
   ```

2. Übertrage die Änderungen ins System mit:

   ```bash
   ./dev-env
   ```

3. Optional: Lade deine Änderungen auf GitHub hoch mit:

   ```bash
   ./dev-git
   ```

4. Optional: Speichere alle manuell installierten Pakete in:

   ```bash
   ./get-dependencies
   ```

   Die Paketliste findest du dann in `~/dev/dependencies`.


## 🚀 Installation

```bash
git clone https://github.com/Jannis241/dev.git ~/dev
cd ~/dev
./setup
./dev-env

