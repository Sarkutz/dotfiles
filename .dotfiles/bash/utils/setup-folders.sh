#!/usr/bin/env bash

# TODO
# - Fix errors during DRY_RUN
# - Ensure no state changes during DRY_RUN

# Configs.
# ========

# ONLY_EXPORT_PATHS
# -----------------
# This is useful if we only want to setup the env. vars. to get the dotfiles
# to work but, we do not want to create the paths.
# ONLY_EXPORT_PATHS=1

# DRY_RUN
# -------
# DRY_RUN=1

if [[ $DRY_RUN -eq 1 ]]
then
  MKDIR='echo mkdir'
  LN='echo ln -s'
else
  MKDIR='mkdir -p'
  LN='ln -s'
fi

# PREFIX
# ------
# Path in which to create the folders.
PREFIX="$HOME"

# PATH_INFO
# ---------
# PATH_INFO can be sourced to get the name of paths created by this script.
# Note: Do NOT change as base.sh searches for this file in the following path.
PATH_INFO=${DOTFILES}/utils/path-info.sh


# Export Paths
# ============

# Ensure $DOTFILES is set
if [[ -z $DOTFILES ]]; then
  echo 'Please set $DOTFILES'
  exit 1
fi


cat <<EOF > $PATH_INFO
export DOTFILES_REPOS="$PREFIX/resources/repos"
export DOTFILES_SOFTWARE_INSTALL_PREFIX="$PREFIX/resources/software/installed/"
export DOTFILES_SOFTWARE_STANDALONE="$PREFIX/resources/software/standalone/"
export DOTFILES_GTD="$PREFIX/private/gtd/"
export DOTFILES_KNOWL="$PREFIX/private/knowl/"
export DOTFILES_DIARY="$PREFIX/private/diary/"
export DOTFILES_PYENVS="$PREFIX/resources/software/pyenvs/"
export DOTFILES_WWW="$PREFIX/public/www/"
export DOTFILES_PERSONAL_WORKSPACE="$PREFIX/ashim"
export DOTFILES_CLINIC_WORKSPACE="$PREFIX/clinic"
# Note: FREEPLANE_PATH exported by home.sh
EOF
source $PATH_INFO

if [[ $ONLY_EXPORT_PATHS -eq 1 ]]; then
  echo "Quiting after exporting paths to $PATH_INFO"
  exit 0
fi


# Functions
# =========

# Utils
# -----

function mkdir_if_not_exists() {
  dir="$1"
  [[ $( ls -a | grep -i "$dir" | wc -l ) -eq 0 ]] &&
    $MKDIR "$dir"
}

function create_workspace() {
  space_name="$1"
  mkdir "$space_name"
  cd "$space_name" &&
    $MKDIR sandbox projfg projbg projint projar knowl wiki
}

# Folder Setup
# ------------

function setup_base() {
  cd "$PREFIX" &&
    $MKDIR resources
  
  cd "$PREFIX/resources/" &&
    $MKDIR data ashim repos \
        software/archive/vm software/installed/bin software/pyenvs software/standalone

  cp $DOTFILES/../resources/trashit.sh         $DOTFILES_SOFTWARE_INSTALL_PREFIX/bin
  cp $DOTFILES/../resources/sqlout2csv.py      $DOTFILES_SOFTWARE_INSTALL_PREFIX/bin
  cp $DOTFILES/../resources/jsbeautify.py      $DOTFILES_SOFTWARE_INSTALL_PREFIX/bin
  cp $DOTFILES/../resources/painlessmerge.sh   $DOTFILES_SOFTWARE_INSTALL_PREFIX/bin
  cp $DOTFILES/../resources/make-proj-dirs.sh  $DOTFILES_SOFTWARE_INSTALL_PREFIX/bin
  cp $DOTFILES/../resources/is-repo-dirty.sh   $DOTFILES_SOFTWARE_INSTALL_PREFIX/bin
  cp $DOTFILES/../resources/tsv2csv.sh         $DOTFILES_SOFTWARE_INSTALL_PREFIX/bin
  cp $DOTFILES/../resources/pyenvs/*.requirements.txt $DOTFILES_PYENVS
  # TODO Check if $DOTFILES_WWW exists
  cp $DOTFILES/../knowl/index.html $DOTFILES_WWW
  cp $DOTFILES/../knowl/phpinfo.php $DOTFILES_WWW
}

function setup_home() {
  setup_base

  cd "$PREFIX" &&
    mkdir_if_not_exists downloads
  
  cd "$PREFIX" &&
    $MKDIR private public archives storage
  
  # MacOS Only
  [[ $(get_os) == 'mac_os' ]] &&
    sudo /bin/mv Public/ public
  
  cd "$PREFIX/private/" &&
    $MKDIR active secret gtd knowl anki orgzly diary zotero ghosh-family/ashim
  
  cd "$PREFIX/public/" &&
    $MKDIR website www file-share
  
  cd "$PREFIX/public/website/" &&
    $LN "$PREFIX/private/knowl/" &&
    $MKDIR online/blog online/kbase


  cd "$PREFIX/" &&
    create_workspace ashim
  cd "$PREFIX/" &&
    create_workspace clinic
}


setup_home
