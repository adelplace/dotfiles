export PATH="$PATH:/home/adelplace/.local/bin"
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(git z)

source $ZSH/oh-my-zsh.sh

alias vim=nvim
alias v=nvim
alias lg=lazygit
alias ld=lazydocker
alias rm=rip

[ -f /opt/nvim-linux64 ] && export PATH="/opt/nvim-linux64/bin:$PATH"

#FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#GCLOUD
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/google-cloud-sdk/completion.zsh.inc'; fi

#NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
