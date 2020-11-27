# Path to your oh-my-bash installation.
export OSH=$HOME/.oh-my-bash

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
if [ -v WT_SESSION ]; then
    OSH_THEME="powerline-multiline"
else
    OSH_THEME="duru"
fi

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  git
  ssh
  makefile
  pip3
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
  ls
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  bashmarks
)

if [ -d $OSH ]; then
    source $OSH/oh-my-bash.sh
else
    # Use case-insensitive filename globbing
    shopt -s nocaseglob

    # When changing directory small typos can be ignored by bash
    # for example, cd /vr/lgo/apaache would find /var/log/apache
    shopt -s cdspell

    export LESS="-RXMF"
    alias ls='ls -hF --color=tty'                 # classify files in colour
    alias df='df -h'
    alias du='du -h'

    if ((BASH_VERSINFO[0] >= 4)); then
        # prompt
        D=
        hash lsb_release 2>/dev/null && D="$(lsb_release -is) "
        U=$(id -un)
        [[ $U == markw_000 ]] && U=mark
        [[ $(id -G) =~ $(echo '\<544\>') ]] && PSE="\[\e[31m\]Elevated! " || PSE=""
        PS1="\[\e]0;\w\a\]\n$PSE\[\e[32m\]$D$U@\h \[\e[33m\]\w\[\e[0m\]\n\$ "
        source /usr/share/bash-completion/completions/git
    fi
fi

export LS_COLORS='ow=01;102'

alias log='git log --graph --all --pretty=format:"%C(yellow)%h %C(white)(%cr) %C(bold cyan)%an%Creset %C(red)%d %C(white)%s"'

# you know, cls, clear screen from TRS-80 basic, :-)
alias cls='tput clear'

# borrow open idea from the mac, fix to be cygwin only
alias open='cygstart'

#set the make mode to unix for the mingw32 projects
MAKE_MODE=unix

# markdown
mdview ()
{
    pandoc -s -f markdown -t man "$1" | man -l -
}

# where from here down
wh ()
{
    find . -iname "$1"
}

# display motd again
motd ()
{
    for i in /etc/update-motd.d/*; do
        if [ "$i" != "/etc/update-motd.d/98-fsck-at-reboot" ]; then
            $i;
        fi;
    done
}

export CSCOPE_EDITOR=vim
export VISUAL=vim
