# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="sunrise"
# Cool themes: muse, juanghurtado(?), nanotech, sunrise, eastwood, gallois,
# gentoo, kphoen, 

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew gem git git-flow extract osx ruby vagrant)

# Input controls
bindkey '^[[1;3D' backward-word    # alt + LEFT
bindkey '^[[1;3C' forward-word     # alt + RIGHT
bindkey '_^?' backward-delete-word # alt + BACKSPACE  delete word backward
bindkey '^[[3;3~' delete-word      # alt + DELETE  delete word forward
bindkey '^[' self-insert           # alt + ENTER  allow multiline input
bindkey '_t' transpose-words

source $ZSH/oh-my-zsh.sh

# PATH helper functions from http://superuser.com/questions/408912

# is $1 missing from $2 (or PATH) ?
no_path() {
    eval "case :\$${2-PATH}: in *:$1:*) return 1;; *) return 0;; esac"
}
# if $1 exists and is not in path, append it
add_path () {
    [ -d ${1:-.} ] && no_path $* && eval ${2:-PATH}="\$${2:-PATH}:$1"
}
# if $1 exists and is not in path, prepend it
pre_path () {
    [ -d ${1:-.} ] && no_path $* && eval ${2:-PATH}="$1:\$${2:-PATH}"
}
# if $1 is in path, remove it
del_path () {
    no_path $* || eval ${2:-PATH}=`eval echo :'$'${2:-PATH}: |
        sed -e "s;:$1:;:;g" -e "s;^:;;" -e "s;:\$;;"`
}

alias gf="git flow"
alias gl="git log --pretty=oneline --decorate=full --abbrev-commit"

function git_log_from() {
    git log --pretty=oneline --abbrev-commit --max-age=`date -j -f "%Y-%m-%d" "$1" "+%s"`
}

if ([[ -d /usr/local/Cellar/ ]])
then
    del_path /usr/local/bin
    del_path /usr/local/sbin
    pre_path /usr/local/bin
    pre_path /usr/local/sbin
    if (brew --prefix coreutils &>/dev/null 2>&1); then
        pre_path "$(brew --prefix coreutils)/libexec/gnubin"
    fi
fi

if (ls --color -d . &>/dev/null 2>&1)
then
    LS_COLOR='--color'
    eval $(dircolors ~/.dir_colors)
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
else
    LS_COLOR='-G'
fi

LS_CMD="ls $LS_COLOR -Fh"

alias ls="$LS_CMD"

# List directory contents
alias lsa="$LS_CMD -la"
alias l="$LS_CMD -la"
alias ll="$LS_CMD -l"
alias sl="$LS_CMD" # often screw this up
eval "$(thefuck --alias)"

# List directory contents after a 'cd'
function chpwd() {
    emulate -LR zsh
    ls
}


function nbopen {
    if test -z "$1"
    then
      echo "usage: nbopen [file]"
    else
      open /Applications/NetBeans/NetBeans\ 8.0.1.app && /Applications/NetBeans/NetBeans\ 8.0.1.app/Contents/MacOS/netbeans --open $1
    fi
}

export EDITOR=vim

# A way to get IP addresses {
    # http://stackoverflow.com/a/13322549/359059
    alias myip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
# }

alias pelilabra="ssh root@pelilabra.net -t 'screen -DRU'"
alias hp1="ssh hp1 -t 'tmux attach || tmux'"

# Show/Hide hidden files/directories
alias showdot="defaults write com.apple.finder AppleShowAllFiles -boolean true ; killall Finder"
alias hidedot="defaults write com.apple.finder AppleShowAllFiles -boolean false ; killall Finder"

pre_path '/Applications/MAMP/bin/php/php5.4.10/bin'

pre_path "$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

export PATH
export RUBYOPT=-Ku

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH::/usr/local/Cellar/ansible/1.7.2/bin/"

export NVM_DIR="/Users/joni/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="$PATH:/Users/joni/Development/mongodb/bin" #mongodb
alias gm="/usr/local/Cellar/graphicsmagick/1.3.24/bin/gm" #GraphicsMagick
