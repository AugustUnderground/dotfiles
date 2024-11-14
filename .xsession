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
#export PATH=/usr/local/plan9/bin:$PATH

export DMENU_THEME="-fn 'VictorMono NFM:size=12' \
                    -nb '#060404' \
                    -nf '#FFF6F6' \
                    -sb '#222222' \
                    -sf '#FFF6F6' \
                    -nhb '#060404' \
                    -nhf '#8F0024' \
                    -shb '#222222' \
                    -shf '#8F0024' \
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
