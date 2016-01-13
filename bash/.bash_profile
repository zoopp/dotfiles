#
# ~/.bash_profile
#

# If available, load the local .bash_profile before running this script
[ -r ".bash_profile.local.before" ] && source .bash_profile.local.before


# Export local bin path and load user bashrc
export PATH=~/.local/bin:$PATH
[[ -f ~/.bashrc ]] && . ~/.bashrc


# If available, load the local .bash_profile after running this script
[ -r ".bash_profile.local.after" ] && source .bash_profile.local.after

# And finally, If we login from tty1 start the graphical environment
[ $(tty) = "/dev/tty1" ] && startx
