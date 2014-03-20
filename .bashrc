#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load aliases
[ -r ".bash_aliases" ] && source .bash_aliases
# Load color constants if available
[ -r ".bash_colors" ] && source .bash_colors

# Update path in order to use CCACHE for compilations
export PATH="~/.local/bin:$PATH"

# Java font fix
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp -Dswing.aatext=true -Dswing.plaf.metal.controlFont="Droid Sans" -Dswing.plaf.metal.userFont="Droid Sans"'
export JAVA_FONTS='/usr/share/fonts/TTF'

EDITOR=vim

# Color man pages using less
export LESS_TERMCAP_mb=$'\E[01;31m'             # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'             # begin bold
export LESS_TERMCAP_me=$'\E[0m'                 # end mode
export LESS_TERMCAP_se=$'\E[0m'                 # end standout-mode
export LESS_TERMCAP_so=$'\E[01;44;33m'          # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'                 # end underline
export LESS_TERMCAP_us=$'\E[00;33m'             # begin underline

PS1="\[${COLOR_BLUE}\]\n┌─┤\[${COLOR_BOLD}\]\t\[${COLOR_RESET}${COLOR_BLUE}\]│"\
"\u@\h:\[${COLOR_CYAN}\]\w\n\[${COLOR_BLUE}\]└──────────╼\[${COLOR_RESET}\] "
