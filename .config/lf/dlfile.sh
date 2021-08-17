#!/bin/sh

if [ "$#" -lt 1 ] || [ ! -d "$1" ]; then
    exit 1
fi

FILEPATH="$1"

[ -z "$2" ] && X=" -x" || X=""

URLS=$(dragon-drag-and-drop -t$X)

for URL in $URLS; do
    FILENAME="$FILEPATH/$(basename $URL)"

    if [ -n "$URL" ]; then
        while [ -e "$FILENAME" ]; do
            OW=$(echo -e "Yes\nRename\nCancle" | \
                   dmenu -nb darkblue -nf gray -sb blue -sf white \
                         -fn "Monofur Nerd Font:pixelsize=15:autohint=true:style=Book" \
                         -bw 2 -h 25 -w 550 -x 50 -y 50 \
                         -i -p "File already exists, overwrite?")
            if [ $OW == "Cancel" ]; then
                exit 0
            elif [ $OW == "Rename" ]; then
                NEWFILE="$(echo "$(ls $FILEPATH)" | dmenu -nb darkblue -nf gray -sb blue -sf white \
                                            -fn "Monofur Nerd Font:pixelsize=15:autohint=true:style=Book" \
                                            -bw 2 -h 25 -w 550 -x 50 -y 50 -l 5 \
                                            -i -p "New Filename:")"
                FILENAME="$FILEPATH/$NEWFILE"
            else
                break
            fi
        done
        [ -n "$FILENAME" ] && wget -O "$FILENAME" "$URL" || exit 1
    else
        exit 1
    fi

done


