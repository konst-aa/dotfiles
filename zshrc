TERM=xterm-256color
ZSH_CUSTOM=~/.config/oh-my-zsh

# source ~/.oh-my-zsh/oh-my-zsh.sh
plugins=(
  fzf
  git
  nix-shell # doesn't exist without manual installation
)
autoload -Uz compinit
compinit

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
alias cat="bat"
alias tvi="nvim +Goyo"
alias cshell="nix-shell -p chicken chickenPackages.chickenEggs.breadline"
alias gitssh='ssh-add ~/.ssh/*github'
alias astaff-gitlab='ssh-add ~/.ssh/astaff-gitlab'
alias nineteeneightyfour="git filter-repo --invert-paths" # literally 1984

alias edit-nvim="nvim ~/.config/nvim/init.lua"
alias edit-xmonad="nvim ~/.config/xmonad/xmonad.hs"
alias edit-sway="nvim ~/.config/sway/config"
alias edit-zsh="nvim ~/.zshrc"
alias edit-aerospace="nvim ~/.config/aerospace/aerospace.toml"
alias edit-nixos="sudo nvim /etc/nixos/"
alias nixd="nix develop -c zsh"
alias resource="exec zsh"
alias info='info --vi-keys'

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

function pyenv() {
    if [ -d .venv ]; then
        source .venv/bin/activate
    elif [ -d venv ]; then
        source venv/bin/activate
    fi
    if [ -f .env ]; then
        export $(grep -v "^#" .env | xargs)
    fi
}

function nrebuild() {
  sudo nixos-rebuild switch --flake /etc/nixos/#$1
}

eval $(ssh-agent) > /dev/null


export EDITOR=nvim
export PATH="/opt/google-cloud-cli/bin/:$PATH:$HOME/.dotnet/tools:$HOME/dotfiles/g-scripts:$HOME/Android/Sdk/tools/bin:/usr/local/go/bin:$HOME/.local/bin"

# docker
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"

# ADB (G.O.A.T.)
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

export PATH=/usr/local/cuda-12.2/bin${PATH:+:${PATH}}

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
# export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

# export FZF_DEFAULT_COMMAND="find ."

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# app-specific
# Set up fzf key bindings and fuzzy completion


if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi


if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -f $(command -v fzf) ]; then
    source <(fzf --zsh)
fi

# big boy postgres user
export PSQL_PAGER='pspg'

# fnm
FNM_PATH="/Users/konst/Library/Application Support/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/Users/konst/Library/Application Support/fnm:$PATH"
  eval "`fnm env`"
fi

if command -v fnm &> /dev/null; then
    eval $(fnm env)
fi

[ -f ~/.ghcup/env ] && source ~/.ghcup/env # ghcup-env

export PATH

[ -f "~/.ghcup/env" ] && source "~/.ghcup/env" # ghcup-env
[ -f "~/.cargo/env" ] && source "~/.cargo/env"

[ -f ".local/bin/env" ] && source "$HOME/.local/bin/env"


