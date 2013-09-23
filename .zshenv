export EDITOR='vim'
export ANDROID_HOME="$HOME/SDK/android-sdk-macosx"
export TODO=~/Dropbox/todo
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_13.jdk/Contents/Home"
export JDK_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_13.jdk/Contents/Home"
export AWS_IAM_HOME="$HOME/aws-dev/IAMCli-1.5.0"
export AWS_CREDENTIAL_FILE=$HOME/.elasticbeanstalk/aws_credential_file
export CLASSPATH="$CLASSPATH:$HOME/.lein/self-installs/leiningen-1.7.1-standalone.jar"
export GOPATH="~/Dropbox/Projects/go"
export GOROOT="/usr/local/Cellar/go/1.0.3"
# PATH
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:$HOME/bin:/usr/local/share/python:/usr/local/share/python3
export PATH=$PATH:$HOME/SDK/jdk/bin # JDK 
export PATH=$PATH:$HOME/aws-dev/eb/macosx/python2.7/ # Elastic Beanstalk tool
export PATH=$PATH:$HOME/.cabal/bin # Haskell binaries 
export PATH=$PATH:$HOME/aws-dev/IAMCli-1.5.0/bin 
export PATH=$PATH:/Applications/Racket\ v5.3.5/bin
export PATH=$PATH:/usr/local/munki
export PATH=$PATH:$HOME/.rbenv/versions/1.9.3-p327/bin

export WORKON_HOME=~/env
# active venv in prompt managed by oh-my-zsh theme
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
