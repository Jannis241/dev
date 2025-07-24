# Meine Dotfiles für Arch Linux mit Hyprland

Dieses Repository enthält meine persönlichen Dotfiles für Arch Linux mit dem Fenstermanager **Hyprland**.

## Features

- Hyprland-Konfiguration
- Shell- und Editor-Settings
- Einfaches Setup-Skript zur automatischen Einrichtung

## Voraussetzungen

- Arch Linux (oder kompatible Distribution)
- Hyprland installiert
- Git

## Installation

Kopiere einfach alle folgenden Befehle nacheinander in dein Terminal:

```bash

# 1. Klone das Repository
git clone https://github.com/Jannis241/dev.git ~

# 2. Wechsle in das geklonte Verzeichnis
cd dev

# 3. Führe das Setup-Skript aus
./setup

# 4. Starte ggf. deinen PC neu.

# 5. kopiere alle Konfigurationen. (ACHTUNG: alle jetzigen Config werden gelöscht!)
# Führe dieses script nur aus, wenn dieses repo in ~/dev liegt. Ansonsten musst du
# DEV_ENV in deinem .bashrc oder .zshrc file zu dem jeweiligen Speicherort ändern.
./dev-env

# 6. starte dein Terminal neu.




