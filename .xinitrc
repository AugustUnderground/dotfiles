#!/bin/sh

#$HOME/dotfiles/scripts/setwp.sh -w

if [ -z ${LANG+x} ]; then
    export LANG="en_US.UTF-8"
    export LC_CTYPE="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
fi

if [ -f $HOME/wp ]; then
    hsetroot -tile $HOME/wp -tint "#51001d"
else
    hsetroot -solid "#0d0d0e"
fi

[ -n "$(command -v dunst)" ] && dunst&
[ -n "$(command -v picom)" ] && picom --backend xr_glx_hybrid -b
[ -n "$(command -v mpd)" ] && mpd
[ -n "$(command -v nm-applet)" ] && nm-applet&

exec dbus-launch $WM
