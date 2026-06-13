export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export DEV_ENV="${DEV_ENV:-$HOME/dev}"

export LUA_VERSION=5.1
export LUA_INCDIR=/usr/include/lua5.1
export LUA_LIBDIR=/usr/lib

typeset -U path
path=(
	"$HOME/.local/scripts"
	"$HOME/.local/bin"
	"$HOME/.cargo/bin"
	/usr/local/bin
	$path
)
export PATH

export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"

_xdg_data_prepend() {
	case ":$XDG_DATA_DIRS:" in
		*":$1:"*) ;;
		*) export XDG_DATA_DIRS="$1:$XDG_DATA_DIRS" ;;
	esac
}

_xdg_data_prepend "$HOME/.local/share/flatpak/exports/share"
_xdg_data_prepend /var/lib/flatpak/exports/share
unset -f _xdg_data_prepend
