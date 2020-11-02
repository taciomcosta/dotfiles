# The following lines were added by compinstall
zstyle :compinstall filename '/home/taciomcosta/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

ZSH_THEME="robyrussell"

# append bash path
export PATH=$PATH:/home/taciomcosta/.asdf/shims:/home/taciomcosta/Downloads/asdf/bin:/home/taciomcosta/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/var/lib/snapd/snap/bin

# show current folder
export PS1="[%2~]$ "

# Go Variables
export GOPATH=$(go env GOPATH)
export GOBIN=$(go env GOPATH)/bin
export GOROOT=$(go env GOROOT)
export PATH=$PATH:$GOPATH:$GOBIN

export EDITOR=/usr/bin/nvim

# make FZF user ripgrep by default
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
