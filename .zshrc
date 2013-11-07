ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"
#plugins=(git github python ruby rvm mercurial vi-mode zsh-syntax-highlighting)

umask 002

source $ZSH/oh-my-zsh.sh

# handy aliases
alias e="mvim"
alias ssh="ssh -AX"
alias rpry="rails-console-pry -r pry-doc -r awesome_print"
alias df="df -H"
alias hr="hg record"
alias hs="hg status"
alias ls="ls -h"
alias sml="rlwrap sml"
# needed for 256 colours in term2
alias tmux="TERM=screen-256color-bce tmux"

# binds
bindkey -v
bindkey '^R' history-incremental-search-backward

# todos
function todo(){ if [ $# -eq 0 ]; then cat $TODO; else echo "• $@" >> $TODO; fi }
function todone() { sed -i -e "/$*/d" $TODO; }

function check_response() { curl -s -w %{time_total}\\n -o /dev/null $1 }

# virtualenv activate
activate() {
    export VIRTUAL_ENV_DISABLE_PROMPT='1'
      source ~/env/$1/bin/activate
    }
. /usr/local/share/python/virtualenvwrapper.sh
# set user@host only on remote hosts
[[ -n "$SSH_CLIENT" ]] || export DEFAULT_USER="kit"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
