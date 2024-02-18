# https://stackoverflow.com/a/2534676
# andd https://gist.github.com/reinvanoyen/05bcfe95ca9cb5041a4eafd29309ff29

TERM=xterm-256color
ZSH_CUSTOM=~/.config/oh-my-zsh
plugins=(
  fzf
  nix-shell # doesn't exist without manual installation
)

function pretty_branch() {
  # https://stackoverflow.com/questions/1593051/how-to-programmatically-determine-the-current-checked-out-git-branch
  branch_name="$(git symbolic-ref HEAD 2>/dev/null)"
  branch_name=${branch_name##refs/heads/}
  if [ -z $branch_name ]; then
    echo ""
  else
    echo " $1git:($branch_name)$2"
  fi
}

setopt prompt_subst

PROMPT='%F{202}<%n@%m>%F{208} %T$(pretty_branch %F{202} %F{208}) %B%20<..<%~%b %(!.#.>) %F{white}'
if [[ $IN_NIX_SHELL != "" ]]
then
  PROMPT='%F{135}<%n@%m>%F{140} %T$(pretty_branch %F{135} %F{140}) %B%20<..<%~%b %(!.#.>) %F{white}'
fi

source ~/.ls_colors.zsh


alias vi="nvim" #lol
alias ls="lsd"
alias tvi="nvim +Goyo"
alias gitssh='ssh-add ~/.ssh/github'
alias 1984="git filter-repo --invert-paths" # literally 1984
alias edit-nvim="nvim ~/.config/nvim/init.lua"
alias edit-xmonad="nvim ~/.config/xmonad/xmonad.hs"
alias edit-sway="nvim ~/.config/sway/config"
alias edit-zsh="nvim ~/.zshrc"
alias nixd="nix develop -c zsh"
alias conf='() { cd $HOME/.config/$1 }'
alias ssh-forward="ssh -R 6000:localhost:22 -N pult@ssh.ka.dreadmaw.industries"


eval $(ssh-agent) > /dev/null

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export EDITOR=nvim
export PATH="$PATH:$HOME/.dotnet/tools:$HOME/dotfiles/g-scripts:$HOME/Android/Sdk/tools/bin:/usr/local/go/bin"
export PATH=/usr/local/cuda-12.2/bin${PATH:+:${PATH}}
# export FZF_DEFAULT_COMMAND="find ."

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# app-specific


if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

# [ -f "~/.ghcup/env" ] && source "~/.ghcup/env" # ghcup-env

