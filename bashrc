eval $(ssh-agent)
alias gitssh="ssh-add ~/.ssh/github"
alias ghc="ghc -no-keep-o-files -no-keep-hi-files"
. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
