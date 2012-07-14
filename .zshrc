ZSH=$HOME/.oh-my-zsh
ZSH_THEME="kit"
plugins=(git github python ruby rvm mercurial vi-mode)

source $ZSH/oh-my-zsh.sh

# aliases
alias e="mvim"
alias ssh="ssh -C4c arcfour,blowfish-cbc"
alias rpry="rails-console-pry -r pry-doc -r awesome_print"


# general
export EDITOR='vim'
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:$HOME/bin:/usr/local/share/python
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export TODO=~/Dropbox/todo
export CLASSPATH="$CLASSPATH:$HOME/.lein/self-installs/leiningen-1.7.1-standalone.jar"

# todos
function todo(){ if [ $# -eq 0 ]; then cat $TODO; else echo "• $@" >> $TODO; fi }
function todone() { sed -i -e "/$*/d" $TODO; }

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
