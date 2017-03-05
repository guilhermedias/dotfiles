#!/usr/bin/env zsh

homebrew_is_installed() {
  $(which brew > /dev/null)
}

if homebrew_is_installed; then
  echo "Homebrew already installed"
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
source zsh/install.sh
