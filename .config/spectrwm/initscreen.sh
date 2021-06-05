#!/bin/sh

OPTIONS="Primary\nLaptop\nDesktop\nMirror\nExtend\nDock"

MODE=$(sh -c "printf '$OPTIONS' | dmenu $DMENU_THEME -p 'Select Output:'")

PRIM_DISP="$(xrandr | grep -w primary)"
SCND_DISP="$(xrandr | grep -w connected | grep -v primary)"
DISC_DISP="$(xrandr | grep -w disconnected)"

PRIM_ID="$(echo "$PRIM_DISP" | cut -d' ' -f1)"
SCND_ID="$(echo "$SCND_DISP" | cut -d' ' -f1)"
DISC_ID="$(echo "$DISC_DISP" | cut -d' ' -f1)"

case "$MODE" in
    "Laptop")
        echo "$DISC_ID" | xargs -I DISP xrandr --output DISP --off
        xrandr --output $PRIM_ID --auto
    ;;
    "Desktop")
        CNTR_ID="$(echo $SCND_ID | cut -d' ' -f1)"
        RITE_ID="$(echo $SCND_ID | cut -d' ' -f2)"
        xrandr --output $PRIM_ID --off
        xrandr --output $CNTR_ID --primary --auto
        xrandr --output $RITE_ID --right-of $CNTR_ID --auto
    ;;
    "Primary")
        echo "$DISC_ID" | xargs -I DISP xrandr --output DISP --off
        echo "$SCND_ID" | xargs -I DISP xrandr --output DISP --off
        xrandr --output $PRIM_ID --auto
    ;;
    "Dock")
        CNTR_ID="$(echo $SCND_ID | cut -d' ' -f1)"
        RITE_ID="$(echo $SCND_ID | cut -d' ' -f2)"
        xrandr --output $PRIM_ID --auto
        xrandr --output $CNTR_ID --right-of $PRIM_ID --auto
        xrandr --output $RITE_ID --right-of $CNTR_ID --auto
    ;;
    "Mirror")
        xrandr --output $PRIM_ID --auto
        PRIM_RES="$(echo "$PRIM_DISP" | cut -d' ' -f4 | cut -d'+' -f1)"
        echo "$SCND_ID" | xargs -I DISP xrandr --output DISP --same-as $PRIM_ID --scale-from $PRIM_RES --auto
    ;;
    "Extend")
        xrandr --output $PRIM_ID --auto
        echo "$SCND_ID" | xargs -I DISP xrandr --output DISP --left-of $PRIM_ID --auto
    ;;
    *)
        exit 0
    ;;
esac
