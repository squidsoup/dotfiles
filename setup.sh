#!/usr/bin/env bash

# bootstrap new shell
os=${OSTYPE//[0-9.]/}
echo 'Setting up for' $os'...'

if ! hash zsh 2>/dev/null; then
    echo 'Installing zsh and setting to default shell...'
    if [[ $os == 'linux-gnu' ]]; then
        sudo apt-get install zsh;
	chsh -s /usr/bin/zsh $USER
    elif [[ $os == 'darwin' ]]; then
        if ! hash brew 2>/dev/null; then
            ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
        fi
        brew install zsh
	chsh -s /bin/szh $USER
    fi
fi

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

echo 'Setting up git default config...'
git config --global user.email "kit@nocturne.net.nz"
git config --global user.name "Kit Randel" 

echo 'Switching shell...'
zsh
source $HOME/.zshrc
echo 'Done.'
