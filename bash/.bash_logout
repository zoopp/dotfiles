#
# ~/.bash_logout
#

# If available, load the local .bash_logout before running this script
[ -r ".bash_logout.local.before" ] && source .bash_logout.local.before


# If available, load the local .bash_logout after running this script
[ -r ".bash_logout.local.after" ] && source .bash_logout.local.after
