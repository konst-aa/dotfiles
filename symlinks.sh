unlink ~/.config
ln -s $(pwd)/config ~/.config
echo "symlinked .config"

unlink ~/.zshrc
ln -s $(pwd)/zshrc ~/.zshrc
echo "symlinked zshrc"

echo "symlinks made"
