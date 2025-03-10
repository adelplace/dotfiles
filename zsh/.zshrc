export PATH="$PATH:/home/adelplace/.local/bin:/opt/nvim-linux64/bin:/opt/go/bin:/opt/google-cloud-sdk/bin"
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(git z)

source $ZSH/oh-my-zsh.sh

export BROWSER=google-chrome-stable

alias vim=nvim
alias v=nvim
alias lg=lazygit
alias ld=lazydocker
alias se='echo "dotenv $(ls .env* | fzf)" > .envrc; direnv allow'
alias tw='tmux new-session -A -s adeo -c /home/adelplace/adeo'
alias fd=fdfind

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

[ -f /opt/nvim-linux64 ] && export PATH="/opt/nvim-linux64/bin:$PATH"

#FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}' --bind='?:toggle-preview'"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

#GCLOUD
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/google-cloud-sdk/completion.zsh.inc'; fi

#NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# DIRENV
eval "$(direnv hook zsh)"

# pnpm
export PNPM_HOME="/home/adelplace/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
