#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load aliases
[ -r ".bash_aliases" ] && source .bash_aliases

# Load color constants if available
[ -r ".bash_colors" ] && source .bash_colors

# Local bin folder
export PATH="~/.local/bin/:$PATH"

# Use CCACHE
# export PATH="/usr/lib/ccache/bin/:$PATH"
# export USE_CCAHE=1

# less - sourcecode highlight
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# Java font fix
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'


export EDITOR=vim
export TERMINAL=terminology


shopt -s checkwinsize


PS1="\[${COLOR_BLUE}\]\n┌─┤\[${COLOR_BOLD}\]\t\[${COLOR_RESET}${COLOR_BLUE}\]│"\
"\u@\h:\[${COLOR_CYAN}\]\w\n\[${COLOR_BLUE}\]└──────────╼\[${COLOR_RESET}\] "
