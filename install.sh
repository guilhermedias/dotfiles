#!/usr/bin/env zsh

# Install and update Homebrew
if [ ! $(which brew) ]
then
  echo "Installing Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Brew already installed"
fi

echo "Updating Homebrew"
brew update

# Load configuration modules
source vim/install.sh
