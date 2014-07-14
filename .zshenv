# Some sensible defaults
export os=${OSTYPE//[0-9.]/}
export EDITOR='emacs'
export TODO=~/Dropbox/todo

# PATH
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:/usr/X11/bin:$HOME/bin
export PATH=$PATH:/usr/local/lib/node_modules # npm
export PATH=$PATH:$HOME/SDK/jdk/bin # JDK 
export PATH=$PATH:$HOME/.cabal/bin # Haskell binaries 

export WORKON_HOME=~/env
# active venv in prompt managed by oh-my-zsh theme
export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python"

# rbenv
if hash rbenv 2>/dev/null;then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
