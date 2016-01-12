#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load aliases
[ -r ".bash_aliases" ] && source .bash_aliases

# Load color constants if available
[ -r ".bash_colors" ] && source .bash_colors

# Eval dircolors if available
[ -f ".dircolors" ] && eval `dircolors .dircolors`

# Less - sourcecode highlight
if [ -r "/usr/bin/src-hilite-lesspipe.sh" ]; then
    export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
fi
export LESS=' -R '

export EDITOR=vim
export TERMINAL=termite

shopt -s checkwinsize

PS1="\[${COLOR_BLUE}\]\n┌─┤\[${COLOR_BOLD}\]\t\[${COLOR_RESET}${COLOR_BLUE}\]│"\
"\u@\h:\[${COLOR_CYAN}\]\w\n\[${COLOR_BLUE}\]└──────────╼\[${COLOR_RESET}\] "

# Load local .bashrc if available
[ -r ".bashrc.local" ] && source .bashrc.local
