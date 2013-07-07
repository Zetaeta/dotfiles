#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

#echo "Which desktop environment would you like to use?"
#echo "Choose from GNOME, KDE, XFCE"
#read desktop
#desktop=`echo $desktop | tr '[A-Z]' '[a-z]'`
#desktop_cmd=`cat ~/last_desktop_cmd`
#desktop=`cat ~/.desktop_env`
#echo "Desktop choice: $desktop" >> ~/x.log


#exec ck-launch-session mate-session
#exec kdm
exec myxmonad


# set the cursor
#xsetroot -cursor_name left_ptr
# set UK keyboard layout
#setxkbmap -layout uk
# start xmonad
#exec ck-launch-session xmonad

#case $desktop in
#    gnome)
#        echo "ck-launch-session gnome-session" > ~/last_desktop_cmd
#        echo "Starting GNOME desktop" >> ~/x.log
#        exec ck-launch-session gnome-session
#        ;;
#    kde)
#        echo startkde > ~/last_desktop_cmd
#        echo "Starting KDE desktop" >> ~/x.log
#        exec startkde
#        ;;
#    xfce)
#        echo startxfce4 > ~/last_desktop_cmd
#        exec startxfce4
#        ;;
#    *)
#        echo "Unknown desktop, defaulting to last used." >> ~/x.log
#        exec `cat ~/last_desktop_cmd`
#        ;;
#esac
