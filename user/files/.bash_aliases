alias ls='ls --color=auto -h --group-directories-first'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias diff="colordiff"
alias noise="play -c2 -n synth whitenoise band -n 100 24 band -n 200 100 gain +20"

alias nemo="nemo --no-desktop"

alias ld_primus_steam="LD_PRELOAD='/usr/lib/libstdc++.so.6:/usr/lib/libgcc_s.so.1:/usr/lib/libxcb.so.1:/usr/lib/libasound.so.2' primusrun steam"

# Load local aliases if available
[ -r ".bash_aliases.local" ] && source .bash_aliases.local
