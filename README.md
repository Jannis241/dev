# Dotfiles / Dev Environment

My personal dotfiles for an Arch Linux + Hyprland setup with Zsh, Neovim, Ghostty, Waybar, Rofi and some of my own helper scripts. I use this setup every day, and with the setup script I can install it on a new computer in a few minutes.

## Structure

- `env/`: home overlay that `dev-env` copies to `$HOME`.
- `env/.config/`: configs for `nvim`, `hypr`, `waybar`, `rofi`, `ghostty`, `wlogout` and more.
- `env/.local/scripts/`: my own scripts like `dev-env`, `dev-doctor`, `fix-paru`, `get-dependencies`, `update_script`, `jnew`, `jrun` and `search`.
- `env/.zshenv`, `env/.zprofile`, `env/.zshrc`, `env/.profile`: shell and `PATH` setup.
- `dependencies/`: package lists for pacman, AUR and Flatpak.
- `dev-env`: copies the dotfiles from `env/` to the home directory.
- `dotfiles_setup`: installs packages, enables services and runs `dev-env`.
- `wallpaper.png`: desktop wallpaper.

## From a fresh Arch install to this setup

On an already installed Arch system, as a normal user:

```bash
sudo pacman -Syu --needed git base-devel
git clone https://github.com/Jannis241/dev.git "$HOME/dev"
cd "$HOME/dev"
./dotfiles_setup
```

Dry run without changing anything:

```bash
./dotfiles_setup --dry-run
```

Non-interactive run (as far as the package managers allow it):

```bash
./dotfiles_setup --yes
```

Useful options:

- `--no-packages`: skip pacman packages.
- `--no-aur`: skip paru/AUR.
- `--no-flatpak`: skip Flatpak.
- `--no-dotfiles`: don't copy the dotfiles.
- `--no-services`: don't enable `NetworkManager` and `sddm`.
- `--no-shell`: don't change the login shell to Zsh.

After the setup, log in again or run `exec zsh`.

## Apply the dotfiles manually

When you start `dev-env` directly from the repo, it uses the current repo as `DEV_ENV` by default. After the installation, `.zshenv` sets `DEV_ENV="$HOME/dev"`.

```bash
cd "$HOME/dev"
./dev-env --dry
./dev-env
```

`dev-env` copies:

- `env/.config/*` to `${XDG_CONFIG_HOME:-$HOME/.config}`
- `env/.local/*` to `$HOME/.local`
- the shell files to `$HOME`
- `dev-env` to `$HOME/.local/scripts/dev-env`
- `wallpaper.png` to `$HOME/wallpaper.png`

Existing files at these paths get replaced. So local, host-specific changes should not go directly into the synced files.

## Manual changes

The repo can't know these things automatically:

- Monitor names and layouts (run `hyprctl monitors`, then change `env/.config/hypr/custom_settings.conf`).
- Hostname, Git identity and SSH keys.
- Hardware-specific packages like `nvidia-open`, `amd-ucode`, CUDA, or printer/Bluetooth setup.
- Private paths, tokens, AI tool configs and real SSH notes.
- Whether you want `sddm` as display manager.

## Packages

The package lists are in `dependencies/`:

- `base.txt`: base system, shell, network, package management.
- `desktop.txt`: Hyprland, Wayland, audio, UI tools.
- `dev.txt`: editor, toolchains, linters, formatters, CLI helpers.
- `fonts.txt`: fonts.
- `apps.txt`: applications and hardware-related packages.
- `aur.txt`: AUR packages.
- `flatpak.txt`: Flatpak apps.
- `pacman.txt` and `paru.txt`: combined lists for compatibility.

On the first start, Neovim installs missing plugins with `lazy.nvim`.

