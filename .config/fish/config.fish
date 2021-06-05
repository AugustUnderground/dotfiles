set fish_key_bindings fish_default_key_bindings

set SSID dlink
set PW mqz12sxv83
set -x PATH /home/ynk/node_modules/.bin $PATH
set -x PATH /home/ynk/.local/bin $PATH
set -Ux UI desk

set -g theme_display_user yes

set -gx LD_LIBRARY_PATH '/usr/local/lib'

alias cd..="cd .."
alias xup="xrdb -merge ~/.Xresources"
alias vpn="/opt/cisco/anyconnect/bin/vpn"

function screencap
    scrot '%Y-%m-%d_$wx$h_scrot.png' -e 'mv $f ~/Pictures/screencaps/'
end

function clock
    /usr/local/bin/tty-clock -s -c -C 4
end

#function scim
#    /usr/local/bin/scim
#end

#function lein
#    ~/workspace/cljr/lein $argv
#end

function conwifi
    nmcli device wifi connect $SSID password $PW
end

function incgap
    set gs (bspc config -d focused window_gap)
    bspc config -d focused window_gap (math "$gs+2")
end

function decgap
    set gs (bspc config -d focused window_gap)
    bspc config -d focused window_gap (math "$gs-2")
end

function vpn
    /opt/cisco/anyconnect/bin/vpn
end

function vpnui
    /opt/cisco/anyconnect/bin/vpnui
end

function vpnup
    sudo openvpn --mktun --dev tun1
    sudo ifconfig tun1 up
    sudo openconnect vpn.reutlingen-university.de --interface=tun1
end

function vpndn
    sudo ifconfig tun1 down
    sudo openvpn --rmtun --dev tun1
end

function mountgonzo
    sudo mount -t cifs //gonzo/rbzHome ~/gonzo/ -o username=uhlmanny
end

function startlap
    set -Ux UI lap
    startx
end

function startdesk
    set -Ux UI desk
    startx
    set -Ux ROOTWIN (xwininfo -root | awk '/0xd?/{print $4}')
    xdg-screensaver suspend $ROOTWIN
end

function startbeamer
    set -Ux UI beamer
    startx
end

function catclock
    ~/Downloads/catclock/xclock -mode cat -bg white -fg black &
end

function taz
    tabbed zathura -e
end

function tt
    tabbed urxvt256c-ml -embed
end

function jshell
    ~/workspace/jdk/jdk-11.0.1/bin/jshell
end
