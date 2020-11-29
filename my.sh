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

