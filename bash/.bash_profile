################################################################################
##                              ~/.bash_profile                               ##
################################################################################

function _prepend_path {
    case ":${PATH}:" in
        *:"$1":*)
            ;;
        *)
            export PATH="$1:$PATH"
            ;;
    esac
}


################################################################################
##
BASH_PROFILE_LOCAL_BEFORE="$HOME/.bash_profile.local.before"
BASH_PROFILE_LOCAL_AFTER="$HOME/.bash_profile.local.after"
BASHRC="$HOME/.bashrc"

[[ -r "$BASH_PROFILE_LOCAL_BEFORE" ]] && source "$BASH_PROFILE_LOCAL_BEFORE"

export GOPATH="$HOME/.go"
_prepend_path "$HOME/.go/bin"

_prepend_path "$HOME/.cargo/bin"
_prepend_path "$HOME/.poetry/bin"
_prepend_path "$HOME/.local/bin"

export EDITOR=vim
export TERMINAL=alacritty

source "$BASHRC"

[[ -r "$BASH_PROFILE_LOCAL_AFTER" ]] && source "$BASH_PROFILE_LOCAL_AFTER"


################################################################################
##
unset -f _prepend_path
