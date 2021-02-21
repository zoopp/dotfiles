################################################################################
##                                 ~/.bashrc                                  ##
################################################################################


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s checkwinsize

BASHRC_LOCAL_BEFORE="$HOME/.bashrc.local.before"
ALIASES="$HOME/.bash_aliases"
COLORS="$HOME/.bash_colors"
DIRCOLORS="$HOME/.dircolors"
VTE_INIT="/etc/profile.d/vte.sh"
VIRTUALENV_WRAPPER_INIT="/usr/bin/virtualenvwrapper_lazy.sh"
FZF_INIT="$HOME/.fzf.bash"
BASHRC_LOCAL_AFTER="$HOME/.bashrc.local.after"


[[ -f "$BASHRC_LOCAL_BEFORE" ]] && source "$BASHRC_LOCAL_BEFORE"

source "$ALIASES"
source "$COLORS"
eval `dircolors "$DIRCOLORS"`

[[ -r "$VTE_INIT"                ]] && source "$VTE_INIT"
[[ -x "$VIRTUALENV_WRAPPER_INIT" ]] && source "$VIRTUALENV_WRAPPER_INIT"
[[ -f "$FZF_INIT"                ]] && source "$FZF_INIT"

# Code highlight for less
if [[ -r "/usr/bin/src-hilite-lesspipe.sh" ]]; then
    export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
    export LESS='-R'
fi


PS1="\[${COLOR_BLUE}\]\n┌─┤\[${COLOR_BOLD}\]\t\[${COLOR_RESET}${COLOR_BLUE}\]│"\
"\u@\h:\[${COLOR_CYAN}\]\w\n\[${COLOR_BLUE}\]└──────────╼\[${COLOR_RESET}\] "

[[ -f "$BASHRC_LOCAL_AFTER" ]] && source "$BASHRC_LOCAL_AFTER"
