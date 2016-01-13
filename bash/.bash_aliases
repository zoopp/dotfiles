alias ls='ls --color=auto -h --group-directories-first'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias diff="colordiff"
alias noise="play -c2 -n synth whitenoise band -n 100 24 band -n 200 100 gain +20"

alias nemo="nemo --no-desktop"

alias wanip="dig +short myip.opendns.com @resolver1.opendns.com"

# If available, load local .bash_aliases
[ -r ".bash_aliases.local" ] && source .bash_aliases.local
