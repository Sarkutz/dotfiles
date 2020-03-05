# home.sh
#
# *Contains BASH configs. for personal computer*.
#
# Usage: Source this file.
#
# Prerequisite:
# - $DOTFILES is set
# - dev.sh

# Pre-requisites
# ==============

source "${DOTFILES}/dev.sh"


# Misc/All (a)
# ============


# System (s)
# ==========


# Development (d)
# ===============

# gtd: Start GTD resources
freeplane_path=
which 'freeplane'
if [[ $? -eq 0 ]]
then
    freeplane_path='freeplane'
else
    # mac_freeplane_path='/Applications/Freeplane.app/Contents/MacOS/JavaAppLauncher'
    mac_freeplane_path='/Applications/Freeplane.app'
    if [[ -e "$mac_freeplane_path" ]]
    then
        freeplane_path="open $mac_freeplane_path"
    fi
fi
export FREEPLANE_PATH="$freeplane_path"
alias gtd='$FREEPLANE_PATH $DOTFILES_GTD/clarify.mm $DOTFILES_GTD/gtd-dash.mm &> /dev/null & vim $DOTFILES_GTD/scratch.rst'


# Jump (j)
# ========


# Tools/Kit (k)
# =============

