#!/bin/bash


# ----------------------------------------------------------------------------------------------------
function red {
    echo "`tput setaf 1`$@`tput sgr0`"
}

function require_commands {
    local should_quit=false
    for cmd in $@; do
        command -v "$cmd" >/dev/null 2>&1 || {
            echo >&2 "Please install `red $cmd` and run this script again."
            should_quit=true
        }
    done

    if $should_quit; then
        echo Aborting.
        exit 1
    fi
}


# ----------------------------------------------------------------------------------------------------
require_commands ls cut stow git curl make


# ----------------------------------------------------------------------------------------------------
# Symlink dotfiles
stow -v --no-folding -t "$HOME" `ls -1 -d */ | cut -f1 -d'/'` 


# ----------------------------------------------------------------------------------------------------
# Do parallel setup
make -j5 -f setup.makefile
