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

primary=202
secondary=208
if [[ $IN_NIX_SHELL != "" ]]
then
  primary=135
  secondary=140
fi

# https://stackoverflow.com/a/2534676
PROMPT='%F{$primary}<%n@%m>%F{$secondary} %T$(pretty_branch %F{$primary} %F{$secondary}) %B%20<..<%~%b %(!.#.>) %F{white}'

source ~/.ls_colors.zsh


alias vi="nvim" #lol
alias ls="lsd"
alias cat="batcat"
alias tvi="nvim +Goyo"
alias gitssh='ssh-add ~/.ssh/github'
alias 1984="git filter-repo --invert-paths" # literally 1984
alias edit-nvim="nvim ~/.config/nvim/init.lua"
alias edit-xmonad="nvim ~/.config/xmonad/xmonad.hs"
alias edit-sway="nvim ~/.config/sway/config"
alias edit-zsh="nvim ~/.zshrc"
alias nixd="nix develop -c zsh"
alias conf='() { cd $HOME/.config/$1 }'
alias cde='() { cd $HOME/code/$1 }'
alias rezsh='source ~/.zshrc'
alias add-key='() { ssh-add ~/.ssh/$1 }'
alias list-keys="ls ~/.ssh"
alias pyenv='source venv/bin/activate && [ ! -f .env ] || export $(grep -v "^#" .env | xargs)'


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

export PATH

# [ -f "~/.ghcup/env" ] && source "~/.ghcup/env" # ghcup-env

