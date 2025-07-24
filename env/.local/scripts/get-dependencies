#!/bin/bash

# Setze Zielverzeichnis relativ zu diesem Script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
OUT_DIR="$DOTFILES_DIR/dependencies"

rm -rf "$OUT_DIR"

mkdir -p "$OUT_DIR"

echo "📦 Exportiere installierte Pakete nach: $OUT_DIR"

# Pacman (nur explizit installierte Pakete)
pacman -Qqe | awk '{print $1}' > "$OUT_DIR/pacman.txt"

# Paru AUR Pakete
if command -v paru &> /dev/null; then
    paru -Qqe | awk '{print $1}' > "$OUT_DIR/paru.txt"
else
    echo "⚠️ paru nicht gefunden"
fi


# Flatpak Pakete
if command -v flatpak &> /dev/null; then
    flatpak list --app --columns=application > "$OUT_DIR/flatpak.txt"
else
    echo "⚠️ flatpak nicht gefunden"
fi

echo "✅ Fertig! Paketlisten sind in $OUT_DIR"

