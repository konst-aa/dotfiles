if [ "$1" == "--system" ]; then
	SYSTEM_PATH=$(pwd)/system-specific/$2
	echo "symlinking to current-os: $SYSTEM_PATH"
	# for easy access
	unlink ~/.current-os
	ln -s $SYSTEM_PATH ~/.current-os
	# add the config
	unlink ~/.config
	ln -s ~/.current-os/config ~/.config
	sh $SYSTEM_PATH/setup.sh
fi

pairs=(
	"cabal_config .cabal/config"
	"ssh_config .ssh/config"
	"ls_colors.zsh .ls_colors.zsh"
	"zshrc .zshrc"
	"csirc.scm .csirc"
	"oh-my-zsh .config/oh-my-zsh"
	"nvim .config/nvim"
	"coc .config/coc"
	"kitty .config/kitty"
)

for i in "${pairs[@]}"
do
	set $i
	echo "symlinking $1"
	unlink ~/$2
	ln -s $(pwd)/$1 ~/$2
done

echo "symlinks updated"
