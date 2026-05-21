#!/usr/bin/env bash

set -e

MODE="$1"

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

FILE="$DIR/Screenshot from $(date '+%Y-%m-%d %H-%M-%S').png"

case "$MODE" in
    area)
        grim -g "$(slurp)" "$FILE"
        ;;

    screen)
        grim "$FILE"
        ;;

    window)
        grim -g "$(slurp -o)" "$FILE"
        ;;
esac

wl-copy < "$FILE"

notify-send "Screenshot saved" "$(basename "$FILE")"
