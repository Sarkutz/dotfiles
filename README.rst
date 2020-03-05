
##########
 Dotfiles
##########

.. |git-repo-url| replace:: https://github.com/Sarkutz/dotfiles.git


**************
 Introduction
**************

The motivation of this repository is to allow moving my configurations from
one machines to another in a simple and reproducable manner.


**************
 Installation
**************

Install these dotfiles by performing the following steps in order.

.. contents:: Installation Steps
   :local:
   

Install Dotfiles
================

Clone and install as follows (`source
<https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/>`__)::

  git clone --bare |git-repo-url| $HOME/.dotfiles.git
  alias kdfgit='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
  kdfgit checkout
  if [ $? = 0 ]; then
    echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    mkdir -p .config-backup
    kdfgit checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
  fi;
  kdfgit checkout
  kdfgit submodule init
  kdfgit submodule update --recursive
  kdfgit config status.showUntrackedFiles no
  kdfgit config status.submodulesummary 1

Setup Folders
-------------

Optionally, run :file:`utils/setup-folders.sh` to create the folder hierarchy. ::

  export DOTFILES=$HOME/.dotfiles/bash/
  bash $DOTFILES/utils/setup-folders.sh

If required, configure :file:`utils/setup-folders.sh` before running the
script.  The following can be configured by editing the script.

- Call appropriate ``setup_*`` function at the end of the file.  Default:
  :code:`setup_home`.
- Set :code:`ONLY_EXPORT_PATHS` variable to 1, if we want to export the
  env. vars.  without creating the paths.
- Set PREFIX variable, if required.  Default: :code:`$HOME` env. var.
- Set DRY_RUN to 1 to check what changes the script would make.  (No changes
  are made during dry run.)


Install Dependencies
====================

Install `Dependencies`_.


Setup Python
============

- Ensure Anaconda/Miniconda is installed as per `Install Dependencies`_.

Install Python Utilities
------------------------

Ensure that the following are also installed

- Python3: If system does not have Python3, either install using system's
  package manager, activate Conda's Python installation, or `Install Python
  (from sources)`_ as detailed below.

- Python2: Python3 has pip and virtualenv built-in.  However, for Python2,
  these must be installed.

  - ``pip``: Install using `get-pip.py
    <https://pip.pypa.io/en/stable/installing/#installing-with-get-pip-py>`__

  - ``virtualenv``::

      pip install virtualenv

Install Python (from sources)
-----------------------------

.. TODO: Deprectate this???

Many Vim plugins require at least Python 2.7.  Unfortunately, some Linux
distributions still run with older versions of Python.  If this is the case
with your machine, you will need to install Python (and Vim) from sources.
Otherwise, you can use the package manager to install Vim.

Download the latest version of Python 2.* from `python.org <http://python.org>`__.

Install using the `usual process to build from sources
<https://passingcuriosity.com/2015/installing-python-from-source/>`__::

  ./configure --prefix=$HOME/resources/software/installed
  make
  make test
  make install


Install Python Virtual Environments
-----------------------------------

Setup Python virtual enviroments (for ``dve``)::

  export DOTFILES=$HOME/.dotfiles/bash/
  source $DOTFILES/utils/path-info.sh

  cd "$DOTFILES_PYENVS" && \
    ls *.requirements.txt | \
    xargs -I '{}' bash -c "echo '{}' | cut -d. -f1" | \
    xargs -I '{}' bash -c "python3 -m venv '{}' && cd '{}' && source bin/activate && mv '../{}.requirements.txt' requirements.txt && pip install -r requirements.txt"

.. note::

   If you get "Could not find a version that satisfies the requirement" error,
   try changing the version of the problematic package in the problematic
   :file:`$DOTFILES_PYENVS/*.requirements.txt` file.


Install Crontab
===============

Add the following to the current user's crontab::

   # Sync GTD using Dropbox (hourly)
   0 * * * * rsync -ru --exclude '*.sw?' ~/private/gtd/ ~/Dropbox/gtd/ && rsync -ru --exclude '*.sw?' ~/Dropbox/gtd/ticker/ ~/private/gtd/ticker/


Install Utilities (Optional)
============================

You might also want to install the following useful utilities-

.. list-table:: Common Utilities
   :widths: auto
   :header-rows: 1

   * - Utility
     - Installation Source
     - Notes

   * - ``tmux``
     - Distro's package manager.
     -

   * - ``initmux``
     - Install from Git repo as mentioned on `iasj/IniTmux <https://github.com/iasj/IniTmux>`__.
     - Notes-

       + Might need to alter the first line to #!/usr/bin/env python3.
       + inittmux's config files are provided by this repo in ``.config/initmux/*.yaml``.

   * - ``tree``
     - System's package manager
     -

   * - ``curl`` and ``wget``
     - System's package manager
     -

   * - Sphinx Document Generator
     - PyPI
     - Install into a python venv (perhaps the doc venv) using pip.

   * - Anki
     - System's package manager
     - https://apps.ankiweb.net

       Import your old Anki decks, if required.

   * -
     -
     -

.. list-table:: Linux-only Utilities
   :widths: auto
   :header-rows: 1

   * - Utility
     - Installation Source
     - Notes

   * - redshift
     - System's package manager
     - Linux only.  Not required on Mac.


.. list-table:: Mac-only Utilities
   :widths: auto
   :header-rows: 1

   * - Utility
     - Installation Source
     - Notes

   * - Karabiner Elements
     - `Karabiner-Elements GitHub page
       <https://github.com/pqrs-org/Karabiner-Elements>`__
     -

   * - Jumpcut
     - System's package manager
     - For Mac OS only::

         brew cask install jumpcut


Install Vim (from sources)
==========================

.. TODO: Deprecate Vim???

We need to build Vim with either Python 2 (``+python``) or Python 3
(``+python3``) support.

On Debian-based systems, it is `not possible
<https://vi.stackexchange.com/a/2231>`__ to link both Python 2 and Python 3
to Vim.  Hence, we choose any one.

Install using the `usual process to build from sources
<https://passingcuriosity.com/2015/installing-python-from-source/>`__::

  source $DOTFILES/utils/path-info.sh

  # For Python 2
  ./configure --prefix=$DOTFILES_SOFTWARE_INSTALL_PREFIX --enable-pythoninterp --with-python-config-dir=$DOTFILES_SOFTWARE_INSTALL_PREFIX/bin/lib/python2.7/config
  # For Python 3 (change path as appropriate)
  ./configure --prefix=$DOTFILES_SOFTWARE_INSTALL_PREFIX --enable-python3interp --with-python3-config-dir=$DOTFILES_SOFTWARE_INSTALL_PREFIX/bin/lib/python3.6/config-3.6m-x86_64-linux-gnu

  make
  make test
  make install

Note that "config-dir" option should point to the folder containing
``config.c``.

Install NeoVim
==============

Install using System's package manager

- Verify::

     :checkhealth provider


If there is any problem reported for Python, setup Python2 and Python3, as
follows (there are already done when you checkout this repo and run
:file:`setup-folders.sh`):

- Create a separate virtualenv and install ``pynvim``.
- Update ``~/.config/nvim/init.vim``::

    let g:python_host_prog="$DOTFILES_PYENVS/nvimpy2/bin/python"
    let g:python3_host_prog="$DOTFILES_PYENVS/nvim/bin/python3"


Install (Neo)Vim Dependencies/Plugins
=====================================

Install Plugins::

   kdfgit submodule init
   kdfgit submodule update --recursive


.. list-table:: (Neo)Vim Dependencies
   :widths: auto
   :header-rows: 1

   * - Dependency
     - Used by
     - Installation Source
     - Notes

   * - ``rst2confluence.py``
     - ToConflu command in rst filetype
     - Github: `kenichiro22/rst2confluence
       <https://github.com/kenichiro22/rst2confluence>`__
     - ``pip install`` did not work properly.


Install Go (from sources)
=========================

I install go from sources so that, i can keep changing the versions.

Since version 1.5, a working Go installation is required to build Go by
`bootstrapping
<https://docs.google.com/document/d/1OaatvGhEAq7VseQ9kkavxKNAfepWy2yhPUBs96FGV28/edit#!>`__
it.  It's usually possible to download a binary of Go for the target machine
from the Go website to use for the bootstrap::

  source $DOTFILES/utils/path-info.sh

  curl -LSso $DOTFILES_SOFTWARE_STANDALONE/go1.9.2.linux-amd64.tar.gz https://storage.googleapis.com/golang/go1.9.2.linux-amd64.tar.gz
  cd $DOTFILES_SOFTWARE_STANDALONE && tar xzf go1.9.2.linux-amd64.tar.gz
  export GOROOT_BOOTSTRAP=$DOTFILES_SOFTWARE_STANDALONE/go/

Finally, get the source and install it as follows::

  source $DOTFILES/utils/path-info.sh

  git clone https://github.com/golang/go $DOTFILES_REPOS/github.com/golang/go
  cd $DOTFILES_REPOS/github.com/golang/go/src && ./all.bash
  export PATH=$DOTFILES_REPOS/github.com/golang/go/bin:$PATH


Install BASH
============

Add the following to :file:`~/.profile`::

  # ~/.profile is called for interactive login shells.

  # if running bash
  if [ -n "$BASH_VERSION" ]; then
      # include .bashrc if it exists
      if [ -f "$HOME/.bashrc" ]; then
          . "$HOME/.bashrc"
      fi
  fi

Add the following to :file:`~/.bashrc`::

  # ~/.bashrc is called for interactive non-login shells.

  export DOTFILES=$HOME/.dotfiles/bash/
  source ${DOTFILES}/home.sh

::

  source ~/.profile


****************
 Setup Overview
****************

Dependencies
============

Different part of the dotfiles use the following dependencies.  It's
recommended to install these dependencies before installing the dotfiles.

.. list-table:: Dependencies
   :widths: auto
   :header-rows: 1

   * - Dependency
     - Used by
     - Installation Source
     - Notes

   * - Git
     - Needed to clone dotfiles.
     - Distro's package manager.
     -

   * - (Neo)Vim
     - ``e`` alias
     - Distro's package manager.
     - See `Install NeoVim`_.

   * - Anaconda/Miniconda Python Distribution
     - Python Alias Space
     - `Anaconda <https://docs.anaconda.com/anaconda/install/>`__/
       `Miniconda <https://docs.conda.io/en/latest/miniconda.html>`__.

       For example, download the Miniconda installation script and execute as
       follows::

          bash Miniconda3-latest-MacOSX-x86_64.sh -b -p $DOTFILES_SOFTWARE_STANDALONE/miniconda3

     - No need to initialise Miniconda.  This can be done by calling
       ``act_conda`` (Defined in the Python Alias Space).  Prefer Miniconda?

   * - Python
     - Python Alias Space
     - Distro's package manager.  Alternatively install from sources as
       mentioned in `Install Python (from sources)`_.
     -

   * - Java Development Kit
     - System and utilities like Freeplane.
     - System's package manager.
     -

   * - Freeplane
     - ``gtd`` alias in home.sh; GTD workflow
     - System's package manager.
     -

       + Copy gtd-dash.mm and revisit.mm to $DOTFILES_GTD
       + Copy template-dreams-topic.mm to appropriate directory
       + Setup Freeplane keyboard shortcuts.

   * - Golang
     - Go Alias Space
     - From sources.  See `Install Go (from sources)`_.
     -

   * - ``xclip``
     - ``scc`` and ``spc`` aliases in base.sh
     - Distro's package manager.  Repo: `astrand/xclip
       <https://github.com/astrand/xclip>`__
     - Required for Linux.  On Mac OS X, we use ``pbcopy`` and ``pbpaste``
       commands instead of ``xclip``.  Hence, ``xclip`` is not required.

   * - ``jq``
     - Various utilities (base.sh)
     - Distro's package manager.  `Website
       <https://stedolan.github.io/jq/>`__.
     - .

   * - ``brew``
     - Various BASH dotfiles.
     - `Homebrew website <https://brew.sh/>`__
     - Occurances of "system package manager" means Homebrew on Mac.

   * - Dropbox
     - Required to sync GTD.
     - `Dropbox website <https://www.dropbox.com/>`__
     - .

   * -
     -
     -
     -


Dotfiles
========

Please find the details of the dotfiles provided by this repository.

.. list-table:: Configuration Files (dotfiles)
   :widths: auto
   :header-rows: 1

   * - Dependency
     - Notes

   * - tmux
     - Single file: .tmux.conf from this repo

   * - BASH
     - Files in :file:`.dotfiles/bash/` from this repo.  See
       `Install BASH`_.  See :file:`.dotfiles/bash/README.rst`.

   * - Git
     - :file:`$HOME/.gitconfig` from this repo.

   * - Vim
     - :file:`.vimrc` (which sources files in :file:`.dotfiles/vim/`), files in
       :file:`.vim/` (including plugins as subrepositories in
       :file:`.vim/bundle/`).

   * - NeoVim
     - :file:`$HOME/.config/nvim/init.vim` from this repo.

   * - initmux
     - Files in :file:`.config/initmux/` from this repo.

   * - Golang
     - Workspace directory structure.  Anything else?

   * - Node.js ???
     - TODO: Single file :file:`.npmrc`???

   * - Nginx localhost configuration
     - Single file :file:`.dotfiles/knowl/nginx-localhost.conf`.

   * -
     -


Utilities
=========

Please find the details of the utilities provided in this repository as follows.

.. list-table:: Utilities in this repo
   :widths: auto
   :header-rows: 1

   * - Utility
     - Notes

   * - trashit.sh
     -

   * - painlessmerge.sh
     - Required by :file:`$HOME/.gitconfig`.

   * - jsbeautify.py
     - Used in JavaScript Alias Space.

   * -
     -


(Neo)Vim Plugins
================

Please find the details of the (Neo)Vim plugins provided by this repository.

.. list-table:: (Neo)Vim Plugins
   :widths: auto
   :header-rows: 1

   * - Plugin
     - Class
     - Description

   * - ``vim-pathogen``
     - Plugin Manager
     - The original Plugin Manager.  Installation (as per `tpope/vim-pathogen
       <https://github.com/tpope/vim-pathogen>`__)::

         curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

   * - gruvbox
     - Visuals
     - Light color scheme that is easy on the eyes.  Installation::

         curl -LSso $HOME/.vim/color/gruvbox.vim https://raw.githubusercontent.com/morhetz/gruvbox/master/colors/gruvbox.vim

   * - zenburn
     - Visuals
     - Good dark color scheme.  Currently deactivated as it only has a dark
       color scheme.  Installation::

         curl -LSso $HOME/.vim/color/zenburn.vim https://raw.githubusercontent.com/jnurmine/Zenburn/master/colors/zenburn.vim

   * - lightline
     - Visuals
     - Configurable, informative status line.  Installation: Clone
       `itchyny/lightline <https://github.com/itchyny/lightline.vim>`__.
       Also clone 
       `morhetz/gruvbox <https://github.com/morhetz/gruvbox.git>`__ for
       colors.

   * - LeaderF
     - Navigator
     - Fuzzy Finder to find files, buffers, tags, previous commands, etc.
       Installation: Clone `Yggdroot/LeaderF
       <https://github.com/Yggdroot/LeaderF.git>`__.

   * - vim-surround
     - Misc.
     - Enclosing text in paranthesis (or in any other character/tag).
       Installation: Clone `tpope/vim-surround
       <https://github.com/tpope/vim-surround.git>`__.

   * - vim-unimpaired
     - Misc.
     - Installation: Clone `tpope/vim-unimpaired
       <https://github.com/tpope/vim-unimpaired.git>`__.

   * - cscope_maps
     - Dev.
     - Cscope bindings.  Installation::

         curl -LSso $HOME/.vim/bundle/cscope_maps/plugin/cscope_maps.vim http://cscope.sourceforge.net/cscope_maps.vim

   * - rst.vim
     - Dev (reST).
     - Folding for RestructuredText.  Installation: Clone `ganwell/rst.vim
       <https://github.com/ganwell/rst.vim.git>`__.

   * - SimplyFold
     - Dev. (Python)
     - Folding for Python.  Installation: Clone `tmhedberg/SimpylFold
       <https://github.com/tmhedberg/SimpylFold.git>`__.

   * - csv.vim
     - Dev., ML
     - Processing CSV files.  Installation: Clone `chrisbra/csv.vim
       <https://github.com/chrisbra/csv.vim.git>`__.

   * - Nvim-R
     - Dev. (R), ML
     - IDE for R.  Installation: Clone `jalvesaq/Nvim-R
       <https://github.com/jalvesaq/Nvim-R.git>`__.

   * - vim-go
     - Dev. (Go)
     - IDE for Go.  Installation: Clone `fatih/vim-go
       <https://github.com/fatih/vim-go.git>`__. ::

          :GoInstallBinaries

   * - UltiSnips
     - Dev.
     - Snippet engine.  Installation: Clone `SirVer/ultisnips
       <https://github.com/SirVer/ultisnips.git>`__.  Also install
       vim-snippets.

   * - vim-snippets
     - Dev.
     - Recepie of snippets (required for UltiSnips).  Installation: Clone:
       `honza/vim-snippets <https://github.com/honza/vim-snippets.git>`__.

   * - vim-slime
     - Dev.
     - Send command from vim.  I use it to send command from NeoVim to
       NeoVim's embedded terminal.  Installation: Clone `jpalardy/vim-slime
       <https://github.com/jpalardy/vim-slime.git>`__.

   * - screen
     - Dev.
     - Open a shell in vim and send command to it.  For NeoVim, see vim-slime.
       Installation: Clone `ervandew/screen
       <https://github.com/ervandew/screen>`__.

   * - vim-fugitive
     - Dev.
     - Git commands from vim.  Installation: Clone `tpope/vim-fugitive
       <https://github.com/tpope/vim-fugitive.git>`__.


Repository Creation Details
===========================

This repository was created as follows::

  # In $HOME
  git init --bare $HOME/.dotfiles.git/
  echo ".dotfiles.git" >> .gitignore
  alias kdfgit='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'

  kdfgit config status.showUntrackedFiles no
  kdfgit config status.submodulesummary 1

.. note::

   We can't use the alias to init the repo as git gives the following error::

      fatal: GIT_WORK_TREE (or --work-tree=<directory>) not allowed without specifying GIT_DIR (or --git-dir=<directory>)


Conventions
===========

- All Dotfiles are documented in a ``README.rst`` in the same folder as the Dotfile.

  - TODO: Document .gitconfig
  - See :file:`.dotfiles/bash/README.rst`.

- Key paths are stored in enviroment variables having the form $DOTFILES_*.
  For example, install software from source in the prefix
  $DOTFILES_SOFTWARE_INSTALL_PREFIX.  These variables are exported in
  path-info.sh.  (path-info.sh is generated by setup-folders.sh).

TODO: List out conventions


*************
 Future Work
*************

- In setup-folders.sh-

  - Fix errors during DRY_RUN
  - Ensure no state changes during DRY_RUN

- Creating scaffolding for new project (use Yeoman?)
- Can we use rg instead of grep?
- mutt setup???
- TODO: Golang: org. and add util dir
- TODO: Create SSH keys (any other keys?)
- Should we deprecate building Python and Vim from sources.  This was only
  required for distros that didn't ship with Python 3 enabled in Vim?

