#!/usr/bin/env zsh

vim_is_installed() {
  $(brew ls --versions vim > /dev/null)
}

vim_is_up_to_date() {
  local latest_version=$(brew info vim | grep stable | cut -d ' ' -f3)
  local local_versions=$(brew list --versions vim | sed -n 's/vim //p')

  $(grep -q $latest_version <<< $local_versions)
}

if vim_is_installed; then
  if vim_is_up_to_date; then
    echo "Vim already installed and up-to-date"
  else
    echo "Upgrading Vim"
    brew upgrade vim
    brew cleanup vim
  fi
else
  # Needs to be linked
  brew link gdbm

  echo "Installing Vim"
  brew install vim
fi

echo "Loading Vim configuration"
ln -sf $PWD/vim/config/vimrc ~/.vimrc

mkdir -p ~/.vim/autoload
ln -sf $PWD/vim/config/autoload/plug.vim ~/.vim/autoload/plug.vim

mkdir -p ~/.vim/modules
ln -sf $PWD/vim/config/modules/colors.vim ~/.vim/modules/colors.vim
ln -sf $PWD/vim/config/modules/vimtex.vim ~/.vim/modules/vimtex.vim

mkdir -p ~/.vim/colors
ln -sf $PWD/vim/config/colors/gruvbox.vim ~/.vim/colors/gruvbox.vim

echo "Installing Vim plugins"
vim +PlugClean +PlugInstall +qall
