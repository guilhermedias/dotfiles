# Dotfiles

The install script at the root folder installs the tools used throughout the rest of the process
and then sources the install script of each configuration module (Zsh, Vim, Git, etc).

A configuration module install script should rely on tools installed by the root install script (namely
Homebrew and Homebrew Cask) and tools available in a default Mac OS X - El Capitan installation. There
should be no dependencies on the previous execution of other configuration modules or manually installed
tools.
