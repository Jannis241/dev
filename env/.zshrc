unset PROMPT_EOL_MARK

HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
HISTSIZE=50000
SAVEHIST=50000

setopt autocd
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history

autoload -Uz colors compinit vcs_info
colors
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':vcs_info:git:*' formats ' %F{green}(%b)%f'

precmd() {
	vcs_info
}

PROMPT='%F{blue}%~%f${vcs_info_msg_0_} %# '

alias x='chmod +x'
alias ll='ls -lah'

if [[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
	source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -f "$HOME/.fzf.zsh" ]]; then
	source "$HOME/.fzf.zsh"
fi

if command -v fd >/dev/null 2>&1 && command -v fzf >/dev/null 2>&1; then
	fzf-cd-to() {
		local root="$1"
		local dir

		[[ -d "$root" ]] || return
		dir=$(fd . --type d --hidden --follow --exclude .git "$root" | fzf) || return
		cd "$dir" || return
	}

	fzf-cd-home() {
		fzf-cd-to "$HOME"
	}
	zle -N fzf-cd-home
	bindkey '^H' fzf-cd-home

	if [[ -d "$HOME/programmieren" ]]; then
		fzf-cd-prog() {
			fzf-cd-to "$HOME/programmieren"
		}
		zle -N fzf-cd-prog
		bindkey '^P' fzf-cd-prog
	fi

	fzf-cd-current() {
		fzf-cd-to .
	}
	zle -N fzf-cd-current
	bindkey '^F' fzf-cd-current
fi

if [[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
