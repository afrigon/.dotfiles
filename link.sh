# Move to the dotfile directory
cd $(dirname $BASH_SOURCE);

# Update the dotfiles repository
git pull -q origin master;

# Create symlink to the config files
for file in $(pwd -P)/configs/.*; do
	[ -f "$file" ] || continue
    ln -sf "$file" "$HOME"
done
unset file

touch $HOME/.hushlogin

rm -rf "$HOME/.vim"
cp -R ./configs/.vim "$HOME/.vim"

