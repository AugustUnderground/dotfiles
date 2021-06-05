#!/bin/sh

if [ "$#" -ne 1 ] || [ ! -d "$1" ] ; then
    exit 1
fi

URL=$(dragon-drag-and-drop -t -x)
FILEPATH="$1"
FILENAME="$FILEPATH/$(basename $URL)"
printf "$FILENAME"

if [ -n "$URL" ]; then
    while [ -e "$FILENAME" ]; do
        OW=$(echo -e "Yes\nRename\nCancle" | \
               dmenu -nb darkblue -nf gray -sb blue -sf white \
                     -fn "Monofur Nerd Font:pixelsize=15:autohint=true:style=Book" \
                     -bw 2 -h 25 -w 550 -x 50 -y 50 \
                     -i -p "File already exists, overwrite?")
        if [ $OW == "Cancle" ]; then
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
