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
alias gtd='freeplane $DOTFILES_GTD/revisit.mm $DOTFILES_GTD/gtd-dash.mm &> /dev/null & vim $DOTFILES_GTD/scratch.rst'


# Jump (j)
# ========


# Tools/Kit (k)
# =============

