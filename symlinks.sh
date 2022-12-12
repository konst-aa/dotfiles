pairs=(
	"cabal_config .cabal/config"
	"ssh_config .ssh/config"
	"ls_colors.zsh .ls_colors.zsh"
	"config .config"
	"zshrc .zshrc"
	"csirc.scm .csirc"
)

reroutes=(
	"config/Slack .Slack"
	"config/google-chrome .google-chrome"
	"config/discord .discord"
)
for i in "${pairs[@]}"
do
	set $i
	unlink ~/$2
	ln -s $(pwd)/$1 ~/$2
	echo "symlinked $1"
done

echo "symlinks made"
for i in "${reroutes[@]}"
do
	set $i
	mkdir ~/$2
	ln -s ~/$2 $(pwd)/$1
	echo "symlinked $1 to $2 in the home dir"
done

echo "cleaned up config"
