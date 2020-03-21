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
if [[ $? -eq 0 ]]; then
    freeplane_path='freeplane'
else
    # mac_freeplane_path='/Applications/Freeplane.app/Contents/MacOS/JavaAppLauncher'
    mac_freeplane_path='/Applications/Freeplane.app'
    if [[ -e "$mac_freeplane_path" ]]; then
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
- "t" or "ticker": Jump to todays ticker directory.
- "f" or "find": Find for search_pattern in future/ and jump to matching dir
  jgtd f spark'

    cd $DOTFILES_GTD
    [[ $# -eq 0 ]] && return 0

    command="$1"

    if [[ $command == 't' ]] || [[ $command == 'ticker' ]]; then
        cd ticker/$( date +%Y )/$( date +%m )
        cd $( date +%d )

    elif [[ $command == 'f' ]] || [[ $command == 'find' ]]; then
        if [[ $# -ne 2 ]]; then
            echo "Insufficient parameters" >&2
            echo "$usage" >&2
            return 1
        fi
        command="$1"
        search_term="$2"
        find_and_jump 'future/' "$search_term"

    else
        echo 'Invalid command' >&2
        echo "$usage" >&2
        return 1

    fi

    ls -GCF
}


function jkno() {
    usage='jkno: Jump to knowl directory.
USAGE: jkno [searchterm]
If ``searchterm`` is provided, ``find`` for path that matches ``*searchterm*``.'
    [[ $# -eq 1 ]] && search_term="$1"

    cd ${DOTFILES_KNOWL}/source/
    if [[ $# -eq 1 ]]; then
        find_and_jump ./ "$search_term"
    else
        cd comp
        ls -GCF
    fi
}


# Jump to diary
alias jdia="cd ${DOTFILES_DIARY}/source/$( date +%Y )/$( date +%m ) && ls -GCF"


function jme() {
    usage='jme: Jump to me workspace directory.
USAGE: jme [searchterm]
If ``searchterm`` is provided, ``find`` for path that matches ``*searchterm*``.'
    [[ $# -eq 1 ]] && search_term="$1"

    cd $DOTFILES_PERSONAL_WORKSPACE
    if [[ $# -eq 1 ]]; then
        find_and_jump "knowl/ proj*" "$search_term"
    fi
}

# Tools/Kit (k)
# =============

