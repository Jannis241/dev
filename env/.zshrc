export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export LUA_VERSION=5.1
export LUA_INCDIR=/usr/include/lua5.1
export LUA_LIBDIR=/usr/lib
export PATH="$HOME/.cargo/bin:$PATH"
export XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:/usr/local/share:/usr/share"
export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"
export PATH="$HOME/.local/scripts:$PATH"

export DEV_ENV="$HOME/dev"



ZSH_THEME="robbyrussell"

plugins=(git)


alias x='chmod +x'

source $ZSH/oh-my-zsh.sh

source ~/.zsh_profile



