if [[ $# != 2 && $# != 0 ]]; then
    echo "Usage:"
    echo "    bash symlinks.sh system hostname"
    exit 0
fi

pairs=(
    "aerospace .config/aerospace"
    "autorandr .config/autorandr"
    "bash_profile .bash_profile"
    "bashrc .bashrc"
    "blugon .config/blugon"
    "csirc.scm .csirc"
    "g-scripts/ezforward bin/ezforward"
    "gammastep .config/gammastep"
    "keybindings.json .config/Code/User/keybindings.json"
    "kitty .config/kitty"
    "lispwords .lispwords"
    "ls_colors.zsh .ls_colors.zsh"
    "nix .config/nix"
    "nixpkgs .config/nixpkgs"
    "nvim .config/nvim"
    "oh-my-zsh .config/oh-my-zsh"
    "settings.json .config/Code/User/settings.json"
    "ssh_config .ssh/config"
    "sway .config/sway"
    # "cabal_config .cabal/config"
)

for i in "${pairs[@]}"
do
    set $i
    echo "symlinking $1"
    unlink ~/$2
    ln -s $(pwd)/$1 ~/$2
done

echo "symlinks updated"
