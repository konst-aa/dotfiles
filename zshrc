PROMPT='$%F{cyan}%m:$%F{yellow} %T %B%30<..<%~%b %(!.#.>) %F{white}'
TERM=xterm-256color

plugins=(
	fzf
)

source ~/.nix-profile/share/oh-my-zsh/oh-my-zsh.sh

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

export FZF_DEFAULT_COMMAND="find ."
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
