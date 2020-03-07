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
alias agtd='$FREEPLANE_PATH $DOTFILES_GTD/clarify.mm $DOTFILES_GTD/gtd-dash.mm &> /dev/null & vim $DOTFILES_GTD/scratch.rst'


# Jump (j)
# ========

function jgtd() {
    usage='jgtd: Jump to GTD directory.
USAGE: jgtd [command]
where ``command`` can be-
- "t" or "ticker": Jump to todays ticker directory.'
    if [[ $# -gt 1 ]]; then
        echo "$usage"
        return 1
    fi
    command="$1"

    cd ~/private/gtd
    if [[ $command == 't' ]] || [[ $command == 'ticker' ]]
    then
        cd ticker/$( date +%Y )/$( date +%m )
        cd $( date +%d )
    fi

    ls
}

function jkno() {
    usage='jkno: Jump to knowl directory.
USAGE: jkno [searchterm]
If ``searchterm`` is provided, ``find`` for path that matches ``*searchterm*``.'
    if [[ $# -gt 1 ]]; then
        echo "$usage"
        return 1
    fi
    [[ $# -eq 1 ]] && search_term="$1"

    cd ~/private/knowl/source/
    if [[ $# -eq 1 ]]
    then
        find . -type d -name '*'"$search_term"'*'
    else
        cd comp
        ls
    fi
}

# Jump to diary
alias jdia="cd ~/private/diary/source/$( date +%Y )/$( date +%m ) && ls"

function jme() {
    usage='jme: Jump to me workspace directory.
USAGE: jme [searchterm]
If ``searchterm`` is provided, ``find`` for path that matches ``*searchterm*``.'
    if [[ $# -gt 1 ]]; then
        echo "$usage"
        return 1
    fi
    search_term="$1"

    cd ~/me/
    if [[ $# -eq 1 ]]
    then
        find knowl/ proj*  -type d -name '*'"$search_term"'*'
    fi
}

# Tools/Kit (k)
# =============

