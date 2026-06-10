#!/bin/bash
# 自启动脚本 仅作参考

set +e

# some env can't auto run the portal, so need this
/usr/libexec/xdg-desktop-portal-gtk &
/usr/libexec/xdg-desktop-portal-wlr &
sleep 1
/usr/libexec/xdg-desktop-portal &



# Set GTK dark mode preference (for modern GTK4/libadwaita apps)
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# notify
swaync >/dev/null 2>&1 &

# wallpaper
#swaybg -i ~/Pictures/wallpapers/manga.png >/dev/null 2>&1 &
waypaper --restore >/dev/null 2>&1 &

# top bar
waybar -c /home/swavlabs/.config/waybar/config.jsonc -s /home/swavlabs/.config/waybar/style.css >/dev/null 2>&1 &

# xwayland dpi scale
echo "Xft.dpi: 140" | xrdb -merge #dpi缩放
# xrdb merge ~/.Xresources >/dev/null 2>&1

# ime input
fcitx5 --replace -d >/dev/null 2>&1 &

# keep clipboard content
wl-clip-persist --clipboard regular --reconnect-tries 0 >/dev/null 2>&1 &

# clipboard content manager
wl-paste --type text --watch cliphist store >/dev/null 2>&1 &

# bluetooth 
blueman-applet >/dev/null 2>&1 &

# network
nm-applet >/dev/null 2>&1 &

# Permission authentication
/usr/libexec/polkit-mate-authentication-agent-1 >/dev/null 2>&1 &

# inhibit by audio
sway-audio-idle-inhibit >/dev/null 2>&1 &

# change light value and volume value by swayosd-client in keybind
swayosd-server >/dev/null 2>&1 &

#kdeconnect
kdeconnectd >/dev/null 2>&1 &
kdeconnect-indicator >/dev/null 2>&1 &

podman start searxng >/dev/null 2>&1 &

