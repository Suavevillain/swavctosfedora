#!/usr/bin/env bash

# Get GTK theme (GTK3/GTK4)
GTK_THEME=$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'")

# Get icon theme
ICON_THEME=$(gsettings get org.gnome.desktop.interface icon-theme | tr -d "'")

# Get cursor theme
CURSOR_THEME=$(gsettings get org.gnome.desktop.interface cursor-theme | tr -d "'")

echo "GTK_THEME=${GTK_THEME}"
echo "ICON_THEME=${ICON_THEME}"
echo "XCURSOR_THEME=${CURSOR_THEME}"
