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

source ~/.nix-profile/share/oh-my-zsh/oh-my-zsh.sh
source ~/.ls_colors.zsh

alias vi="nvim" #lol
alias upgrade-os="sudo nixos-rebuild switch"
alias edit-os="sudo nvim /etc/nixos/configuration.nix"
alias edit-pkgs="nvim ~/.config/nixpkgs/config.nix"
alias edit-nvim="nvim ~/.config/nvim/init.vim && uenv myNvim"
alias csi="nix-shell ~/.config/nixpkgs/egg-shell.nix --command csi"
alias cdc="cd ~/code"
alias ls='lsd'
# alias pm2="pm2 --interpreter=none -x"

export VERTEX_HOME=/home/konst/code/vertex
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
# export FZF_DEFAULT_COMMAND="find ."
if [[ $IN_NIX_SHELL != "pure" ]]
then
  # export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
  export NIX_CONF_DIR=~/.config/nixpkgs
  export PATH=$PATH:~/dotfiles/sh:~/.nix-profile/bin:~/.config/npm-globals/node_modules/.bin:~/.cargo/bin
  export BOILER_COMPS=~/dotfiles/sh/boiler_comps
fi
