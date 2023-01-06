# https://stackoverflow.com/a/2534676

PROMPT='%F{202}<%n@%m>%F{208} %T %B%30<..<%~%b %(!.#.>) %F{white}'
if [[ $IN_NIX_SHELL != "" ]]
then
  PROMPT='%F{135}<%n@%m>%F{140} %T %B%30<..<%~%b %(!.#.>) %F{white}'
fi

TERM=xterm-256color
ZSH_CUSTOM=~/.config/oh-my-zsh
plugins=(
  ssh-agent
	fzf
  nix-shell
)

# SUPER DUPER IMPORTANT (system-specific stuff)
source ~/.current-os/zsh-extra
# ^^ (the above was important)
source ~/.ls_colors.zsh


#alias vi="nvim --server ~/.cache/nvim/server/server-a.pipe --remote-silent" #lol
alias vi="nvim" #lol
alias ls='lsd'
alias gitssh='ssh-add ~/.ssh/github'
alias configs="cd ~/.current-os/config"

# alias pm2="pm2 --interpreter=none -x"

export VERTEX_HOME=/home/konst/code/vertex
export MIX_HOME=~/.mix-home

if [[ $IN_NIX_SHELL != "pure" ]]
then
  # export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
  export NIX_CONF_DIR=~/.config/nixpkgs
  export PATH=$PATH:~/.current-os/scripts:~/dotfiles/g-scripts:~/.nix-profile/bin:~/.config/npm-globals/node_modules/.bin:~/.cargo/bin
fi

# nvim servers
mkdir -p ~/.cache/nvim
# in g-scripts, starts a vi server if it doesn't exist under ~/.cache/nvim/server-a.pipe
# visv a

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

