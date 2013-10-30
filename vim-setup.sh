#!/bin/bash

ln -s ~/dotfiles/.vim ~/
ln -s ~/dotfiles/.vimrc ~/
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
