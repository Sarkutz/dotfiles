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

# so: Open file/directory using open command (Mac OS only)
if [[ $(get_os) == 'mac_os' ]]; then
    alias so='open'
fi

# sr: Open ranger (file browser)
alias sr='ranger'


# Development (d)
# ===============

# gtd: Start GTD resources
freeplane_path=
which 'freeplane' &> /dev/null
if [[ $? -eq 0 ]]; then
    freeplane_path='freeplane'
else
    if [[ $(get_os) == 'mac_os' ]]; then
        # mac_freeplane_path='/Applications/Freeplane.app/Contents/MacOS/JavaAppLauncher'
        mac_freeplane_path='/Applications/Freeplane.app'
        if [[ -e "$mac_freeplane_path" ]]; then
            freeplane_path="open $mac_freeplane_path"
        fi
    fi
fi
export FREEPLANE_PATH="$freeplane_path"
alias afreeplane='$FREEPLANE_PATH $DOTFILES_GTD/gtd-dash.mm &> /dev/null &'


# Jump (j)
# ========

function jgtd() {
    usage='jgtd: Jump to GTD directory.
USAGE: jgtd [command]
where ``command`` can be-
- "tickler": Jump to todays tickler directory.
- "dreams": Find for search_pattern in dreams/ and jump to matching dir
Example: jgtd f spark'

    cd $DOTFILES_GTD
    [[ $# -eq 0 ]] && return 0

    command="$1"

    if [[ $command == 'tickler' ]]; then
        cd tickler/$( date +%Y )/$( date +%m )
        cd $( date +%d )
        ls -GCF

    elif [[ $command == 'dreams' ]]; then
        if [[ $# -ne 2 ]]; then
            echo "Insufficient parameters" >&2
            echo "$usage" >&2
            return 1
        fi
        command="$1"
        search_term="$2"
        find_and_jump 'dreams/' "$search_term"

    else
        echo 'Invalid command' >&2
        echo "$usage" >&2
        return 1

    fi
}
function _complete_jgtd() {
    commands="tickler dreams"

    local prev cur
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    case "$prev" in
        tickler)
            return 0
            ;;
        dreams)
            dirs="$( find $DOTFILES_GTD/dreams/ -type d -name '*'"$cur"'*' -exec basename '{}' \; )"
            COMPREPLY=( $( compgen -W "$dirs" -- $cur ) )
            return 0
            ;;
        *)
            ;;
    esac

    COMPREPLY=( $(compgen -W "$commands" -- "$cur" ) )
}
complete -F _complete_jgtd jgtd


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
function _complete_jkno() {
    local prev cur
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    dirs="$( find $DOTFILES_KNOWL/source/ -type d -name '*'"$cur"'*' -exec basename '{}' \; )"
    COMPREPLY=( $( compgen -W "$dirs" -- $cur ) )
}
complete -F _complete_jkno jkno


# Jump to diary
alias 'jdia=cd ${DOTFILES_DIARY}/source/$( date +%Y )/$( date +%m ) && ls -GCF'


function jash() {
    usage='jash: Jump to ashim workspace directory.
USAGE: jash [searchterm]
If ``searchterm`` is provided-
1. Find for a project named ``searchterm`` and jump to it.
2. Find for ``searchterm`` using ``find_and_jump`` and jump to it.'
    [[ $# -eq 1 ]] && search_term="$1"

    cd $DOTFILES_PERSONAL_WORKSPACE

    if [[ $# -eq 1 ]]; then
        find_root="proj*"
        find_output="$( find $find_root -name "$search_term" -depth 1 )"
        get_num_lines "$find_output"
        [[ $? -eq 1 ]] && cd "$find_output" && ls -GCF && return 0

        find_and_jump "knowl/ proj*" "$search_term"
    fi
}
function _complete_jash() {
    local prev cur
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    dirs="$( find $DOTFILES_PERSONAL_WORKSPACE/knowl/ $DOTFILES_PERSONAL_WORKSPACE/proj* \
        -type d -name '*'"$cur"'*' -exec basename '{}' \; )"
    COMPREPLY=( $( compgen -W "$dirs" -- $cur ) )
}
complete -F _complete_jash jash


function jcli() {
    usage='jcli: Jump to clinic workspace directory.
USAGE: jcli [searchterm]
If ``searchterm`` is provided-
1. Find for a project named ``searchterm`` and jump to it.
2. Find for ``searchterm`` using ``find_and_jump`` and jump to it.'
    [[ $# -eq 1 ]] && search_term="$1"

    cd $DOTFILES_CLINIC_WORKSPACE
    if [[ $# -eq 1 ]]; then
        find_root="proj*"
        find_output="$( find $find_root -name "$search_term" -depth 1 )"
        get_num_lines "$find_output"
        [[ $? -eq 1 ]] && cd "$find_output" && ls -GCF && return 0

        find_and_jump "knowl/ proj*" "$search_term"
    fi
}
function _complete_jcli() {
    local prev cur
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    dirs="$( find $DOTFILES_CLINIC_WORKSPACE/knowl/ $DOTFILES_CLINIC_WORKSPACE/proj* \
        -type d -name '*'"$cur"'*' -exec basename '{}' \; )"
    COMPREPLY=( $( compgen -W "$dirs" -- $cur ) )
}
complete -F _complete_jcli jcli


# Tools/Kit (k)
# =============

