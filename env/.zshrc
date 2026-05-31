export ZSH="$HOME/.oh-my-zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

ZSH_THEME="robbyrussell"
unset PROMPT_EOL_MARK

plugins=(git)

cman() {
  man -P "less -S" 3 "$@"
}

alias x='chmod +x'

if [[ -r "$ZSH/oh-my-zsh.sh" ]]; then
	source "$ZSH/oh-my-zsh.sh"
fi

PROMPT='%{$fg_bold[cyan]%}%~%{$reset_color%} $(git_prompt_info)'
# PROMPT='%{$fg_bold[green]%}%n@%m%{$reset_color%} %{$fg_bold[blue]%}%~%{$reset_color%} $(git_prompt_info)'

if command -v fd >/dev/null 2>&1 && command -v fzf >/dev/null 2>&1; then
	fzf-cd-to() {
		local root="$1"
		local dir

		[[ -d "$root" ]] || return
		dir=$(fd . --type d --hidden --follow --exclude .git "$root" | fzf) || return
		cd "$dir" || return
		zle reset-prompt
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
