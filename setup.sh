#!/bin/bash

os=${OSTYPE//[0-9.]/}
# bootstrap new shell
if [[ os == 'linux-gnu' ]]; then
  sudo apt-get install zsh
elif [[ os == 'darwin' ]]; then
  ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
  brew install zsh
fi
chsh -s /bin/zsh $USER
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

ln -fs $HOME/dotfiles/.zshrc $HOME/.zshrc
ln -fs $HOME/dotfiles/.zshenv $HOME/.zshenv

