#!/usr/bin/env bash

# bootstrap new shell
echo 'Detecting OS and checking for zsh...'
os=${OSTYPE//[0-9.]/}


if ! hash zsh 2>/dev/null; then
    echo 'Installing zsh...'
    if [[ os == 'linux-gnu' ]]; then
        sudo apt-get install zsh
    elif [[ os == 'darwin' ]]; then
        if ! hash brew 2>/dev/null; then
            ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
        fi
        brew install zsh
    fi
fi

echo 'Setting zsh to default shell...'
chsh -s /bin/zsh $USER

if ! [[ -d $HOME/.oh-my-zsh ]]; then
    echo 'Installing Oh-My-Zsh!'
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

echo 'Setting up zshrc defaults'
ln -fs $HOME/dotfiles/.zshrc $HOME/.zshrc
if ! [[ -f $HOME/.zshenv ]]; then
    cp $HOME/dotfiles/.zshenv $HOME/.zshenv
fi
echo 'Setting up emacs defaults'
ln -fs $HOME/dotfiles/.emacs.d $HOME/.emacs.d

source $HOME/.zshrc
echo 'Done.'
