#set the make mode to unix for the mingw32 projects
export MAKE_MODE=unix

#less behavior
export LESS="-RXMF"

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

alias where=where.exe
alias open=explorer.exe
alias ag='ag --width 120 --pager less'
