get_vim_files_in() {
  local directory_name=$1

  echo $(ls vim/$directory_name | grep .vim$)
}

link_vim_files_in() {
  local directory_name=$1

  mkdir -p ~/.vim/$directory_name

  for file in $(get_vim_files_in $directory_name)
  do
    echo "Linking file [$directory_name/$file]"
    ln -sf $PWD/vim/$directory_name/$file ~/.vim/$directory_name/$file
  done
}

echo "Installing Vim"
brew install vim

echo "Linking Vim configuration files"
ln -sf $PWD/vim/vimrc ~/.vimrc

link_vim_files_in "autoload"
link_vim_files_in "modules"
link_vim_files_in "colors"

echo "Installing Vim plugins"
vim +PlugClean +PlugInstall +qall
