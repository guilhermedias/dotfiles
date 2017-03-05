echo "Installing Vim"
brew install vim

echo "Linking Vim configuration files"
ln -sf $PWD/vim/vimrc ~/.vimrc

mkdir -p ~/.vim/autoload
ln -sf $PWD/vim/autoload/plug.vim ~/.vim/autoload/plug.vim

mkdir -p ~/.vim/modules
ln -sf $PWD/vim/modules/colors.vim ~/.vim/modules/colors.vim
ln -sf $PWD/vim/modules/nerd-tree.vim ~/.vim/modules/nerd-tree.vim

mkdir -p ~/.vim/colors
ln -sf $PWD/vim/colors/gruvbox.vim ~/.vim/colors/gruvbox.vim

echo "Installing Vim plugins"
vim +PlugClean +PlugInstall +qall
