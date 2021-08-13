#!/bin/sh

if [ -n "$(command -v chafa)" ]; then
    IMVIEWER=chafa
elif [ -n "$(command -v pixterm)" ]; then
    IMVIEWER=pixterm
elif [ -n "$(command -v termpix)" ]; then
    IMVIEWER=termpix
else
    IMVIEWER=file
fi
 
case "$1" in
    *.tar*) tar tf "$1";;
    *.zip) unzip -l "$1";;
    *.rar) unrar l "$1";;
    *.7z) 7z l "$1";;
    *.pdf) pdftotext "$1" -;;
    *.jpg|*.jpeg|*.png|*.bmp|*.gif) $IMVIEWER "$1";;
    *) bat "$1";;
esac
