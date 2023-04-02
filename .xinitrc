#!/bin/sh

#$HOME/dotfiles/scripts/setwp.sh -w

if [ -z ${LANG+x} ]; then
    export LANG="en_US.UTF-8"
    export LC_CTYPE="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
fi

if [ -f $HOME/wp ]; then
    hsetroot -tile $HOME/wp -tint '#424242' # -tint "#d73a49"
else
    hsetroot -solid "#181818"
fi

if [ "$(uname)" = "OpenBSD" ]; then
    xset b off

    wsconsctl mouse.tp.tapping=1

    xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation" 1
    xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Button" 2
    xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Inertia" 1
    xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Axes" 6 7 4 5
fi

[ -n "$(command -v dunst)" ] && dunst&
[ -n "$(command -v picom)" ] && picom --backend xr_glx_hybrid -b
[ -n "$(command -v mpd)" ] && mpd
[ -n "$(command -v nm-applet)" ] && nm-applet&

exec dbus-launch $WM
