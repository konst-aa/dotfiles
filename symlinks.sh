if [[ $# != 2 && $# != 0 ]]; then
	echo "Usage:"
	echo "    bash symlinks.sh system hostname"
	exit 0
fi

pairs=(
	"blugon .config/blugon"
	"cabal_config .cabal/config"
	"coc .config/coc"
	"kitty .config/kitty"
	"ls_colors.zsh .ls_colors.zsh"
	"nix .config/nix"
	"nixpkgs .config/nixpkgs"
	"nvim .config/nvim"
	"oh-my-zsh .config/oh-my-zsh"
	"ssh_config .ssh/config"
	"xmonad .config/xmonad"
	"xmobar .config/xmobar"
	"zshrc .zshrc"
	"bashrc .bashrc"
	"bash_profile .bash_profile"
	"lispwords .lispwords"
	"csirc.scm .csirc"
    "settings.json .config/Code/User/settings.json"
)

for i in "${pairs[@]}"
do
	set $i
	echo "symlinking $1"
	unlink ~/$2
	ln -s $(pwd)/$1 ~/$2
done

echo "symlinks updated"
