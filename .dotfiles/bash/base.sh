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
if [[ $(get_os) == 'mac_os' ]]; then
    alias scc=pbcopy
    alias spc=pbpaste
else
    alias scc='xclip -i -selection clipboard'
    alias spc='xclip -o -selection clipboard'
fi

# scg (Copy to Global) and spg (Paste from Global)
# Copy and paste to all synced devices (Global).
alias 'scg=spc > $DOTFILES_GTD/../secret/clipboard.txt'
alias 'spg=cat $DOTFILES_GTD/../secret/clipboard.txt | scc'

# sol (Open Latest): Open file in current directory that was modified latest.
if [[ $(get_os) == 'mac_os' ]]; then
    alias 'sol=open $( ls -t | head -n 1 )'
fi

# tmuxp
alias 'tmuxpl=$DOTFILES_PYENVS/system/bin/tmuxp load --yes .'
alias 'tmuxpf=$DOTFILES_PYENVS/system/bin/tmuxp freeze --yes --force -o ./.tmuxp.yaml'

# slackm
function slackm() {
    usage='slackm: Send message as a Slack notification
USAGE: slackm <message>
Example:
  export "SECRET_SLACK_INCOMMING_WEBHOOK_URL=..."
  slackm "notify me about this"
Note: message is sent as a JSON string.'
    if [[ $# -ne 1 ]]; then
        echo 'Please provide correct number of arguments'
        echo "$usage"
        return 1
    fi
    message="$1"

    curl -X POST -H 'Content-type: application/json' \
        --data "{\"text\": \"$message\"}" "$SECRET_SLACK_INCOMMING_WEBHOOK_URL"
}

# amxs
function amxs() {
    usage='amxs: Send message as a Matrix notification.
PRECONDITION: Env var SECRET_MATRIX_PASSWORD must be set to a valid matrix user
password that has access to the room.
USAGE: amxs "message"
Example:
  export "SECRET_MATRIX_PASSWORD=..."
  amxs "Hello, world!"'
    if [[ $# -ne 1 ]] || [[ -z $SECRET_MATRIX_PASSWORD ]]; then
        echo 'Please provide correct number of arguments'
        echo "$usage"
        return 1
    fi
    message="$1"

    cd $DOTFILES/utils && $DOTFILES_PYENVS/system/bin/python3 -c \
        "import bashrcutils; bashrcutils.matrix_send('${SECRET_MATRIX_PASSWORD}', '${message}')"
}

# anoti
function anoti() {
	rv=$?

    usage='anoti: Send notification based on return value of previous command to
Matrix room.
PRECONDITION: Preconditions of amxs are met.
USAGE: anoti "Message on success" "Message on failure"
Example:
  cat foo
  anoti "Success" "Fail"'
    if [[ $# -ne 2 ]]; then
        echo 'Please provide correct number of arguments'
        echo "$usage"
        return 1
    fi
	msg_success=$1
	msg_fail=$2

	if [[ $rv -eq 0 ]]; then msg="$msg_success"; else msg="$msg_fail"; fi
	ts=$( date +%Y-%m-%d-%H-%M-%S )
	amxs "($ts): $msg"
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

# dpy: Alias for opening Python bin.
function get_python_bin() {
    which 'ipython' &> /dev/null
    if [[ $? -eq 0 ]]; then
        echo 'ipython'
    else
        # If python not in path, let alias fail.
        echo 'python'
    fi
}
alias dpy='$(get_python_bin)'

# dtag (Tag): Create tags for code navigation
if [[ $(get_os) == 'mac_os' ]]; then
    alias dtag="$( brew --prefix )/bin/ctags -R . 2> /dev/null; cscope -Rb"
else
    alias dtag='ctags -R . 2> /dev/null; cscope -Rb'
fi

# dgd (Grep Directory)
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

