################################################################################
##                              ~/.bash_profile                               ##
################################################################################


BASH_PROFILE_LOCAL_BEFORE="$HOME/.bash_profile.local.before"
BASH_PROFILE_LOCAL_AFTER="$HOME/.bash_profile.local.after"
BASHRC="$HOME/.bashrc"

[[ -r "$BASH_PROFILE_LOCAL_BEFORE" ]] && source "$BASH_PROFILE_LOCAL_BEFORE"

export PATH="$HOME/.local/bin:$PATH"
source "$BASHRC"

[[ -r "$BASH_PROFILE_LOCAL_AFTER" ]] && source "$BASH_PROFILE_LOCAL_AFTER"
