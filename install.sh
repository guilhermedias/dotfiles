#!/usr/bin/env zsh

if which brew > /dev/null; then
  echo "Brew already installed"
else
  echo "Installing Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Updating Homebrew"
brew update

echo "Installing Homebrew Cask"
brew tap caskroom/cask

# Load configuration modules
source vim/install.sh
