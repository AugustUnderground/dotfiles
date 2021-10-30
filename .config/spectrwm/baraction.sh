#!/bin/sh

SIG=""
CON=""
getNetwork()
{
    if [ $(command -v nmcli) ]; then 
        SIG="$(nmcli dev wifi | awk '{if($1=="*" && $2!="SSID")print $8;}')"
        [ -n "$SIG" ] && CON="" || CON=""
    elif [ $(uname) = "Linux" ]; then
        SIG="wired"
        CON=""
    elif [ $(uname) = "OpenBSD" ]; then
        INTERFACE="$(head -1 /etc/resolv.conf | sed 's/^# Generated by \(.*\) dhclient$/\1/')"

        if [ -z "$INTERFACE" ]; then
            CON=""
        else
            IF_TYPE="$(ifconfig $INTERFACE | awk '{if ($1 == "media:") {print $2}}')"
            [ "$IF_TYPE" == "Ethernet" ] && CON="" || CON=""

            if [ -n "$IF_TYPE" ] && [ "$IF_TYPE" != "Ethernet" ]; then
                #DBM="$(ifconfig athn0 | awk '{if ($1 == "ieee80211:") {print $8+0}}')"
                #SIG=$(echo "2 * ($DBM + 100)" | bc)
                SIG="$(ifconfig athn0 | awk '{if ($1 == "ieee80211:") {print $8}}')"
            elif [ -n "$IF_TYPE" ] && [ "$IF_TYPE" == "Ethernet" ]; then
                SIG="wired"
                CON=""
            else
                SIG="disc"
                CON=""
            fi
        fi
    fi
}

getVolume()
{
    if [ $(uname) = "Linux" ]; then
        if [ $(command -v pulsemixer) ]; then 
            VOL="$(pulsemixer --get-volume | cut -d' ' -f 1)"
            MUTE="$(pulsemixer --get-mute)"
        elif [ $(command -v amixer) ]; then 
            VOL=$(amixer sget Master | grep -oP '\d+\%' | sed -Ee 's/%//g' | head -n 1) 
        fi
    elif [ $(uname) = "OpenBSD" ]; then
        VOL=$(echo "$(sndioctl -n output.level) * 100" | bc)
        VOL=${VOL%%.*}
        MUTE="$(sndioctl -n output.mute)"
    elif [ $(uname) = "FreeBSD" ]; then
        VOL=$(mixer vol | awk -F ':' '{print $2}')
        [ $VOL -le 0 ] && MUTE="1" || MUTE="0"
    else
        VOL="0"
        MUTE="1"
    fi
    
    if [ "$MUTE" -eq 1 ]; then
        SPEAKER="ﱝ"
    elif [ "$VOL" -le 0 ]; then
        SPEAKER=""
    elif [ "$VOL" -le 50 ]; then
        SPEAKER=""
    else
        SPEAKER=""
    fi
}

CAP=""
STAT="?"
AC="?"
NOTIF_FULL=false
HED_NOTF="Battery Status"
LOW_NOTF="Battery really low (< 15%), plug me in\!"
FUL_NOTF="Battery fully charged, you can unplug me now."
BEEP='( speaker-test -t sine -f 1300 &> /dev/null)& pid=$!; sleep 0.3s; kill -9 $pid >/dev/null 2>&1'
getBattery()
{
    if [ -d "/sys/class" ]; then
        CAP="$(cat /sys/class/power_supply/*/capacity | head -n 1)"
        STAT="$(cat /sys/class/power_supply/*/status)"
    else
        CAP="$(apm -l)"
        [ $(apm -a) -eq 1 ] && STAT="Charging" || STAT="Discharging"
    fi

    case "$STAT" in
        *Charging* )
            BAT_STAT=""
            ;;
        *Discharging* )
            if [ "$CAP" -le 15 ]; then
                BAT_STAT=""
            elif [ "$CAP" -le 25 ]; then
                BAT_STAT=""
            elif [ "$CAP" -le 50 ]; then
                BAT_STAT=""
            elif [ "$CAP" -le 75 ]; then
                BAT_STAT=""
            else
                BAT_STAT=""
            fi
            ;;
        * )
        BAT_STAT=""
        ;;
    esac

    if [ "$CAP" -le 15 ] && [ "$STAT" != "Charging" ]; then
        NOTIF_FULL=false
        #eval "$BEEP"
        notify-send "$HED_NOTF" "$LOW_NOTF" --icon=battery
    elif [ "$CAP" -gt 99 ] && [ "$STAT" = "Full" ] && [ ! NOTIF_FULL ]; then
        notify-send "$HED_NOTF" "$FUL_NOTF" --icon=battery
        NOTIF_FULL=true
    fi
}

while true; do
    getNetwork
    getVolume
    getBattery

    DATE=" $(/bin/date +"%Y-%m-%d")"
    TIME=" $(/bin/date +"%H:%M")"
    SOUND="$SPEAKER $VOL%"

    case $SIG in
        (*dBm*)
            NET="$CON $SIG"
            ;;
        (wired)
            NET="$CON $SIG"
            ;;
        (disc)
            NET="$CON $SIG"
            ;;
        (*)
            NET="$CON $SIG%"
            ;;
    esac

    [ -z $CAP ] && BAT="$BAT_STAT" || BAT="$BAT_STAT $CAP%"

    STATUS="$SOUND $BAT $NET $DATE $TIME"

    echo "$STATUS"
    
    sleep 1
done

