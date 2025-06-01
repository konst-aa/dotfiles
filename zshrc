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


alias vi="nvim" # lol
alias ls="lsd"
alias cat="batcat"
alias tvi="nvim +Goyo"
alias cshell="nix-shell -p chicken chickenPackages.chickenEggs.breadline"
alias gitssh='ssh-add ~/.ssh/github'
alias nineteeneightyfour="git filter-repo --invert-paths" # literally 1984
alias edit-nvim="nvim ~/.config/nvim/init.lua"
alias edit-xmonad="nvim ~/.config/xmonad/xmonad.hs"
alias edit-sway="nvim ~/.config/sway/config"
alias edit-zsh="nvim ~/.zshrc"
alias edit-aerospace="nvim ~/.config/aerospace/aerospace.toml"
alias resource="source ~/.zshrc"
alias wiki="cd ~/wiki && nvim -c 'Goyo' index.md"
alias myshell="nix-shell -I nixpkgs=/home/konst/nixpkgs/ -p "

function nixd() {
    if [ -z $1 ]; then
        nix develop -c zsh
    elif [[ $1 =~ "#." ]]; then
        nix develop $1 -c zsh
    else
        nix develop .#$1 -c zsh
    fi
}
# alias nixd="() { nix develop $1 -c zsh }"
alias conf='() { cd $HOME/.config/$1 }'
alias cde='() { cd $HOME/code/$1 }'
alias rezsh='source ~/.zshrc'
alias add-key='() { ssh-add ~/.ssh/$1 }'
alias list-keys="ls ~/.ssh"
alias pyenv='source venv/bin/activate && [ ! -f .env ] || export $(grep -v "^#" .env | xargs)'

eval $(ssh-agent) > /dev/null

# nvm is ridiculous
function mnvm () { 
  rm -f ~/.cache/env-cache
  if [[ ! $(command -v nvm) == nvm ]]; then
      source /usr/share/nvm/init-nvm.sh
  fi
  nvm $@
}

# nvm.sh is a > 4k line script to set like three env vars.
# Captures the zeitgeist (lol) very well
# cache it
export NVM_DIR="$HOME/.nvm"
if [ ! -f ~/.cache/env-cache ]; then
    zsh -c 'source $NVM_DIR/nvm.sh && env' \
        | grep 'nvm\|NVM\|PATH' \
        | sed "s/^\([^=]*\)=\(.*\)$/export \1='\2'/"> ~/.cache/env-cache
fi

source ~/.cache/env-cache


export EDITOR=nvim
export PATH="/opt/google-cloud-cli/bin/:$PATH:$HOME/.dotnet/tools:$HOME/dotfiles/g-scripts:$HOME/Android/Sdk/tools/bin:/usr/local/go/bin:$HOME/.local/bin"

export PATH=/usr/local/cuda-12.2/bin${PATH:+:${PATH}}
# export FZF_DEFAULT_COMMAND="find ."

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# app-specific
# Set up fzf key bindings and fuzzy completion

command -v fzf &> /dev/null && source <(fzf --zsh)

if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi


if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

[ -f ~/.ghcup/env ] && source ~/.ghcup/env # ghcup-env

export PATH
