ZSH=$HOME/.oh-my-zsh
ZSH_THEME="kit"
plugins=(git github python ruby rvm osx vi-mode)

source $ZSH/oh-my-zsh.sh

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# aliases
alias e="mvim"


# env
export EDITOR='vim'
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:$HOME/bin
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export TODO=~/Dropbox/todo
export CLASSPATH="$CLASSPATH:$HOME/.lein/self-installs/leiningen-1.6.2-standalone.jar"

# todos
function todo(){ if [ $# -eq 0 ]; then cat $TODO; else echo "• $@" >> $TODO; fi }
function todone() { sed -i -e "/$*/d" $TODO; }
