#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# Merge in defaults
[ -f $sysresources ] && xrdb -merge "$sysresources"
[ -f $sysmodmap ]    && xmodmap "$sysmodmap"

# Merge in user settings
[ -f "$userresources" ] && xrdb -merge "$userresources"
[ -f "$usermodmap" ]    && xmodmap "$usermodmap"

# Start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Setup keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

exec i3
