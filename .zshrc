


ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"
plugins=(git github python mercurial zsh-syntax-highlighting juju nova)
DISABLE_UPDATE_PROMPT=true

source $ZSH/oh-my-zsh.sh

umask 002

# history
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt EXTENDED_HISTORY
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
export HISTFILE HISTSIZE SAVEHIST

# handy aliases
alias e="mvim"
alias ssh="ssh -A"
alias rpry="rails-console-pry -r pry-doc -r awesome_print"
alias df="df -H"
alias du="du -h"
alias hr="hg record"
alias hs="hg status"
alias ls="ls -h --color"
alias sml="rlwrap sml"
alias eamcs="emacs -nw"
alias emacs="emacs -nw"
alias make="noglob make"
alias ack="ack-grep"

if [[ $os != 'darwin' ]]; then
  alias mode="stat -c '%a %n'"
  alias open="xdg-open"
fi
if [[ $os == 'darwin' ]]; then  
  alias flushdns="sudo killall -HUP mDNSResponder"
fi

## tmux
# needed for 256 colours in term2
alias tmux="TERM=screen-256color-bce tmux"

## binds
bindkey -e # emacs mode
bindkey '^R' history-incremental-search-backward

## todos
function todo(){ if [ $# -eq 0 ]; then cat $TODO; else echo "• $@" >> $TODO; fi }
function todone() { sed -i -e "/$*/d" $TODO; }

function check_response() { curl -s -w %{time_total}\\n -o /dev/null $1 }

export VIRTUAL_ENV_DISABLE_PROMPT=
if [ -f "/usr/local/share/python/virtualenvwrapper.sh" ]; then
  . /usr/local/share/python/virtualenvwrapper.sh   
fi
if [ -f "/usr/share/virtualenvwrapper/virtualenvwrapper.sh" ]; then
  . /usr/share/virtualenvwrapper/virtualenvwrapper.sh 
fi
if [ -f "/usr/local/bin/virtualenvwrapper.sh" ]; then
  . /usr/local/bin/virtualenvwrapper.sh   
fi
export WORKON_HOME=~/envs

export NVM_DIR="/home/kit/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# set user@host only on remote hosts
[[ -n "$SSH_CLIENT" ]] || export DEFAULT_USER="kit"

# rbenv
if [ -d "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
