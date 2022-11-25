pairs=(
	"config .config"
	"zshrc .zshrc"
	"csirc.scm .csirc"
)

for i in "${pairs[@]}"
do
	set $i
	unlink ~/$2
	ln -s $(pwd)/$1 ~/$2
	echo "symlinked $1"
done

echo "symlinks made"
