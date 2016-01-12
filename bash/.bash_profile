#
# ~/.bash_profile
#

# Load user bashrc and export local bin path
[[ -f ~/.bashrc ]] && . ~/.bashrc
export PATH=~/.local/bin:$PATH


# Finally if we login from the tty start the graphical environment
[ $(tty) = "/dev/tty1" ] && startx
