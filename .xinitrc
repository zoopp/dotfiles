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

# Load .Xresources file if it exists
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Load display color profile if it exists
[[ -f ~/.color_profile.icm ]] && xcalib ~/.color_profile.icm

# Set keyboard layout
setxkbmap -layout ro -variant cedilla

# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK

# Start awesome-wm
exec awesome
