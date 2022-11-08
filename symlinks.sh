for i in $(ls config); do
	ln -s $(pwd)/config/$i ~/.config/$i
	echo "symlinked $i into .config"
done

rm ~/.zshrc
ln -s $(pwd)/zshrc ~/.zshrc
echo "symlinked zshrc"

echo "symlinks made"
