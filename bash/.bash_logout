################################################################################
##                               ~/.bash_logout                               ##
################################################################################


BASH_LOGOUT_LOCAL_BEFORE="$HOME/.bash_logout.local.before"
BASH_LOGOUT_LOCAL_AFTER="$HOME/.bash_logout.local.after"


[[ -r "$BASH_LOGOUT_LOCAL_BEFORE" ]] && source "$BASH_LOGOUT_LOCAL_BEFORE"


[[ -r "$BASH_LOGOUT_LOCAL_AFTER" ]] && source "$BASH_LOGOUT_LOCAL_AFTER"
