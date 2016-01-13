#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# If available, load the local .bashrc before running this script
[ -r ".bashrc.local.before" ] && source .bashrc.local.before


[ -r ".bash_colors" ] && source .bash_colors
[ -r ".bash_aliases" ] && source .bash_aliases
[ -f ".dircolors" ] && eval `dircolors .dircolors`

shopt -s checkwinsize
export EDITOR=vim
export TERMINAL=termite

# Less - sourcecode highlight
if [ -r "/usr/bin/src-hilite-lesspipe.sh" ]; then
    export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
fi

PS1="\[${COLOR_BLUE}\]\n┌─┤\[${COLOR_BOLD}\]\t\[${COLOR_RESET}${COLOR_BLUE}\]│"\
"\u@\h:\[${COLOR_CYAN}\]\w\n\[${COLOR_BLUE}\]└──────────╼\[${COLOR_RESET}\] "


# If available, load the local .bashrc after running this script
[ -r ".bashrc.local.after" ] && source .bashrc.local.after
