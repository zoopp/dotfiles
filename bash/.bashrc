################################################################################
##                                 ~/.bashrc                                  ##
################################################################################


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s checkwinsize

BASHRC_LOCAL_BEFORE="$HOME/.bashrc.local.before"
BASHRC_LOCAL_AFTER="$HOME/.bashrc.local.after"
BASHRC_DIRCOLORS="$HOME/.dircolors"
BASHRC_ALIASES="$HOME/.bash_aliases"
BASHRC_COLORS="$HOME/.bash_colors"
VTE_INIT="/etc/profile.d/vte.sh"

PYTHON_VIRTUALENV_WRAPPER="/usr/bin/virtualenvwrapper_lazy.sh"
FZF="$HOME/.fzf.bash"

[[ -f "$BASHRC_LOCAL_BEFORE"       ]] && source "$BASHRC_LOCAL_BEFORE"
[[ -x "$PYTHON_VIRTUALENV_WRAPPER" ]] && source "$PYTHON_VIRTUALENV_WRAPPER"
[[ -f "$BASHRC_DIRCOLORS"          ]] && eval `dircolors "$BASHRC_DIRCOLORS"`
[[ -r "$VTE_INIT"                  ]] && source "$VTE_INIT"

source "$BASHRC_COLORS"
source "$BASHRC_ALIASES"

# Source code highlight for less
if [[ -r "/usr/bin/src-hilite-lesspipe.sh" ]]; then
    export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
    export LESS='-R'
fi

export EDITOR=vim
export TERMINAL=termite

PS1="\[${COLOR_BLUE}\]\n┌─┤\[${COLOR_BOLD}\]\t\[${COLOR_RESET}${COLOR_BLUE}\]│"\
"\u@\h:\[${COLOR_CYAN}\]\w\n\[${COLOR_BLUE}\]└──────────╼\[${COLOR_RESET}\] "

[[ -f "$BASHRC_LOCAL_AFTER" ]] && source "$BASHRC_LOCAL_AFTER"
[[ -f "$FZF"                ]] && source "$FZF"
