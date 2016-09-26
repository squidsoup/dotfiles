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
if type trash &> /dev/null; then
  alias rm="trash"
fi
alias e="mvim"
alias ssh="ssh -A"
alias rpry="rails-console-pry -r pry-doc -r awesome_print"
alias df="df -H"
alias du="du -h"
alias hr="hg record"
alias hs="hg status"
alias lxc-ls="sudo lxc-ls --fancy"
alias less="less- FX"
alias ls="ls -h --color"
alias sml="rlwrap sml"
alias eamcs="emacs -nw"
alias emacs="emacs -nw"
alias make="noglob make"
alias ack="ack-grep"
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"
alias rsync="rsync --progress"

if [[ $os != 'darwin' ]]; then
  alias mode="stat -c '%a %n'"
  alias open="xdg-open"
fi
if [[ $os == 'darwin' ]]; then  
  alias flushdns="sudo killall -HUP mDNSResponder"
fi

## dircolors
eval `dircolors ~/dotfiles/dircolors.ansi-dark`
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

function pomo() { sleep 1500 && notify-send "Break" }
function break5() { sleep 300 && notify-send "Back to work" }
function break15() { sleep 900 && notify-send "Back to work" }

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
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# set user@host only on remote hosts
[[ -n "$SSH_CLIENT" ]] || export DEFAULT_USER="kit"

# fix for dumb terminals (emacs tramp)
if [[ "$TERM" == "dumb" ]]
then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  unfunction precmd
  unfunction preexec
  PS1='$ '
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
