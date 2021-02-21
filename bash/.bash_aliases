################################################################################
##                               .bash_aliases                                ##
################################################################################

function has_command {
    command -v "$1" > /dev/null
}


################################################################################
##
BASH_ALIASES_LOCAL="$HOME/.bash_aliases.local"


alias ls='ls --color=auto -h --group-directories-first'
alias sl='ls --color=auto -h --group-directories-first'
if has_command exa; then
    alias ls='exa --header --group --group-directories-first -s Name'
    alias sl='exa --header --group --group-directories-first -s Name'
fi

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias diff="colordiff"
alias wanip="dig +short myip.opendns.com @resolver1.opendns.com"
alias noise="play -c2 -n synth whitenoise band -n 100 24 band -n 200 100 gain +20"

if has_command bat; then
    export BAT_THEME=gruvbox
    alias cat="bat --plain --paging never"
fi

[[ -r "$BASH_ALIASES_LOCAL" ]] && source "$BASH_ALIASES_LOCAL"


################################################################################
##
unset -f has_command
