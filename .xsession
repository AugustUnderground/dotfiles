export LANG=en_US.UTF-8

hsetroot -tile $HOME/wp -tint "#51001d"

xrdb -merge $HOME/.Xresources

export ZSH_CFG="$HOME/.config/zsh"

export PATH=/usr/X11R6/bin/startx:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/scripts:$PATH
export PATH=$HOME/dots/scripts:$PATH
export PATH=$HOME/perl5/bin:$PATH
export PATH=$HOME/.cabal/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.ghcup/bin:$PATH
export PATH=/usr/local/cuda/bin:$PATH
export PATH=/usr/local/plan9/bin:$PATH

export DMENU_THEME="-fn 'FantasqueSansMono Nerd Font:size=15' \
                    -nb '#1d1d1f' \
                    -nf '#cfcfd2' \
                    -sb '#3c3c40' \
                    -sf '#dedee0' \
                    -nhb '#1d1d1f' \
                    -nhf '#51001d' \
                    -shb '#3c3c40' \
                    -shf '#7a002b' \
                    -bw 2 -l 5 -h 25 -x 390 -y 150 -w 600 -i"

export LESS="--RAW-CONTROL-CHARS"
[[ -f ~/dotfiles/.LESS_TERMCAP ]] && . ~/dotfiles/.LESS_TERMCAP
[[ -f ~/.config/lf/ICONS ]] && . ~/.config/lf/ICONS

xset b off

wsconsctl mouse.tp.tapping=1
xinput set-prop "/dev/wsmouse0" "WS Pointer Wheel Emulation" 1
xinput set-prop "/dev/wsmouse0" "WS Pointer Wheel Emulation Button" 2
xinput set-prop "/dev/wsmouse0" "WS Pointer Wheel Emulation Inertia" 1
xinput set-prop "/dev/wsmouse0" "WS Pointer Wheel Emulation Axes" 6 7 4 5

exec dbus-launch spectrwm
