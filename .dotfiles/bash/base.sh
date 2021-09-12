# base.sh
#
# *Contains basic BASH configs. that can be used on all machines*.
#
# Usage: Source this file.
#
# Prerequisite:
# - $DOTFILES is set
# - utils/path-info.sh (created by setup-folders.sh)


# Pre-requisites
# ==============

# Spawn tmux on start up.
# (Not all machines might have tmux installed.)
# [[ -f "$( which tmux 2> /dev/null )" ]] && [[ $TERM != 'screen' ]] && [[ -z $TMUX ]] &&
#     tmux

# Please create path-info.sh by executing utils/setup-folder.sh
source ${DOTFILES}/utils/path-info.sh


# Utilities
# =========

# Import utility functions used by BASH config. files.
source ${DOTFILES}/utils/bashrc-utils.sh


# Misc/All (a)
# ============


# System (s)
# ==========

# sps (Process Search)
alias sps='ps aux | grep -v grep - | grep'

# sj (Jobs)
alias sj='jobs'

# scc (Copy Clipboard) and spc (Paste Clipboard)
if [[ $(uname) == 'Darwin' ]]; then
    alias scc=pbcopy
    alias spc=pbpaste
else
    alias scc='xclip -i -selection clipboard'
    alias spc='xclip -o -selection clipboard'
fi

# scm (Copy from Mobile) and scp (Paste to Mobile)
# Copy and paste to all synced devices.
alias 'scm=cat $DOTFILES_GTD/../active/transfer.txt | scc'
alias 'spm=spc > $DOTFILES_GTD/../active/transfer.txt'

# slackm
function slackm() {
    usage='slackm: Send message as a Slack notification
USAGE: slackm <message>
Example:
  export "SECRET_SLACK_INCOMMING_WEBHOOK_URL=..."
  slackm "notify me about this"
Note: message is sent as a JSON string.'
    if [[ $# -ne 1 ]]; then
        echo "$usage"
        return 1
    fi
    message="$1"

    curl -X POST -H 'Content-type: application/json' \
        --data "{\"text\": \"$message\"}" "$SECRET_SLACK_INCOMMING_WEBHOOK_URL"
}

# BASH
# ----

# Stop terminal flow control
stty -ixon -ixoff

# To fix "ValueError: unknown locale: UTF-8" Python error
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# export LC_CTYPE=en_US.UTF-8  # if required


# Set command prompt (PS)
source "${DOTFILES}/utils/bash-powerline.sh"


# Setup paths
# HomeBrew/LinuxBrew: Add path to sbin.
prefix_to_path '/usr/local/sbin'
# Add binaries added by user.
prefix_to_path "${DOTFILES_SOFTWARE_INSTALL_PREFIX}/bin/"


# Keep longer bash history
if [[ -a ${HOME}/.bash_history ]]
then
    HISTFILE="${HOME}/.bash_history"
    HISTSIZE=1000000000
    HISTFILESIZE=1000000000
    HISTCONTROL=ignorespace
fi


# Safety: rm moves to trash (~/.Trash)
[[ -f $DOTFILES_SOFTWARE_INSTALL_PREFIX/bin/trashit.sh ]] &&
    alias rm='bash $DOTFILES_SOFTWARE_INSTALL_PREFIX/bin/trashit.sh'


# Safety: Prevent mv from overwriting files.
function mv()
{
    # Separate options from filenames
    flags=()
    files=()
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -* )
                flags+=("$1")
                shift
                ;;
            * )
                files+=("$1")
                shift
                ;;
        esac
    done

    source_path="${files[0]}"
    dest_path="${files[1]}"

    will_overwrite "$source_path" "$dest_path"
    [[ $? == 1 ]] &&
        echo "FAIL: Target contains another file with the same filename" &&
        return 1

    /bin/mv ${flags[@]} "$source_path" "$dest_path"
	return $?
}


# Safety: Prevent cp from overwriting files.
function cp()
{
    # Separate options from filenames
    flags=()
    files=()
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -* )
                flags+=("$1")
                shift
                ;;
            * )
                files+=("$1")
                shift
                ;;
        esac
    done

    source_path="${files[0]}"
    dest_path="${files[1]}"

    will_overwrite "$source_path" "$dest_path"
    [[ $? == 1 ]] &&
        echo "FAIL: Target contains another file with the same filename" &&
        return 1

    /bin/cp -rf ${flags[@]} "$source_path" "$dest_path"
	return $?
}


# Development (d)
# ===============

# Set the default editor
[[ "$( which  vim )" ]] && export EDITOR=vim
[[ "$( which nvim )" ]] && export EDITOR=nvim
alias e="$EDITOR"
alias dvi="find . -maxdepth 1 -name '*.sw?'; sps -wE 'n?vim'"

# Always present diff as unified.
alias diff='/usr/bin/diff -u'

# dtag (Tag): Create tags for code navigation
if [[ $(uname) == 'Darwin' ]]; then
    alias dtag="$( brew --prefix )/bin/ctags -R . 2> /dev/null; cscope -Rb"
else
    alias dtag='ctags -R . 2> /dev/null; cscope -Rb'
fi

# dgr (Grep Directory)
function dgd() {
    grep -Rn "$1" . | grep -v 'cscope.out' | grep -v tags | grep "$1"
}

# rest() defined in bashrc-utils.sh


# fg (f)
# ======

alias f='fg'


# Jump (j)
# ========


# Tools/Kit (k)
# =============

# dfgit: dotfiles git: Manipulate the Git bare repo containing all dotfiles
alias kdfgit='git --git-dir=${HOME}/.dotfiles.git/ --work-tree=${HOME}'


# kd (Docker)
alias kd='sudo docker'
# km (minkube)
alias km='minikube'
# kk (kubectl)
alias kk='kubectl'


# ls (l)
# ======

# List: Colored and symbols, multi-column
alias l='ls -GCF'

# ll (List): summarised List
function ll()
{
    ls -lrt $1 | tail
}

