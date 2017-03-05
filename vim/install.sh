echo "Installing Vim"
brew install vim

echo "Linking Vim configuration files"
ln -sf $PWD/vim/config/vimrc ~/.vimrc

mkdir -p ~/.vim/autoload
ln -sf $PWD/vim/config/autoload/plug.vim ~/.vim/autoload/plug.vim

mkdir -p ~/.vim/modules
ln -sf $PWD/vim/config/modules/colors.vim ~/.vim/modules/colors.vim

mkdir -p ~/.vim/colors
ln -sf $PWD/vim/config/colors/gruvbox.vim ~/.vim/colors/gruvbox.vim

echo "Installing Vim plugins"
vim +PlugClean +PlugInstall +qall
