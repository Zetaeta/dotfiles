#!/bin/bash
xrdb ~/.Xresources 
xset +fp /usr/share/fonts/local 
xset +fp /usr/share/fonts/myfonts/limey 
xset +fp /usr/share/fonts/myfonts/lemon 
xset +fp /usr/share/fonts/artwiz-fonts 
xset fp rehash 
#xcalib /home/sunn/x230.icm &
xsetroot -cursor_name left_ptr &
#xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &
setxkbmap gb
xmodmap .Xmodmap
#urxvtd &

source .fehbg

xset r rate 360 25

export GTK2_RC_FILES=$HOME/.gtkrc-2.0

mpd .mpdconf

#hsetroot -fill /home/sunn/Pictures/spring3_DESKTOP.jpg
compton -cbC
#exec dbus-launch xmonad
xmonad
