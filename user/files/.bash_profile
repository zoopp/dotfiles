#
# ~/.bash_profile
#


[[ -f ~/.bashrc ]] && . ~/.bashrc
export PATH=~/.local/bin:$PATH

[ $(tty) = "/dev/tty1" ] && startx
