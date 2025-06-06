
##########
 Dotfiles
##########

.. |git-repo-url| replace:: https://github.com/Sarkutz/dotfiles.git

.. contents:: Contents

**************
 Introduction
**************

The motivation of this repository is to enable setting up a new system and to
share configuration changes between systems in a simple and reproducible
manner.

To this end, this repository bundles all my dotfiles into a single repository.
Dotfiles for individual software are stored in separate sub-folders (under the
``.dotfiles/`` directory) inside this repository.

This document describes the entire system setup (how to install this
repository on a new system; what common software to install; etc.) .  It
also lists the various dotfiles provided by this repository and points to the
appropriate sub-folder for details.


***********************
Repository Dependencies
***********************

The following dependencies need to be installed to fetch this repository to
the system.

.. list-table:: Repository Dependencies
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Dependency
     - Used by
     - Installation Source
     - Notes

   * - Git
     - Required to clone this repository.
     - System's package manager.
     -

Using individual dotfiles (after they have been copied to the system) requires
installing additional dependencies.  As these are different for different
dotfiles, they are documented in the corresponding sub-folder.  Please see the
`Dotfiles Provided`_ section in this document for links to further details.

Dependencies Provided
=====================

The following dependencies are packaged into this repo as submodules.  You do
not need to install them separately.  They will be installed as part of
setting up this repo.

.. list-table:: Dependencies Provided as submodules
   :widths: auto

   * - Name
     - Path

   * - ``pandoc-md-to-slack``
     - ``.dotfiles/resources/pandoc-md-to-slack``


********************
Install All Dotfiles
********************

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
  kdfgit config push.recurseSubmodules check
  kdfgit config submodule.recurse true

Prepare all submodules.  Various dependencies are packaged as submodules. This
step with setup such dependencies. ::

  kdfgit submodule init
  kdfgit submodule update --recursive


*******************
Activating Dotfiles
*******************

Using individual dotfiles (after they have been copied to the system) requires
installing additional dependencies.  Please see the `Dotfiles Provided`_
section in this document for links to further details.

Setup Folders
=============

Optionally, run :file:`.dotfiles/bash/utils/setup-folders.sh` to create the
folder hierarchy. ::

  export DOTFILES=$HOME/.dotfiles/bash/
  bash $DOTFILES/utils/setup-folders.sh

If required, configure :file:`setup-folders.sh` before running the
script.  The following can be configured by editing the script.

- Call appropriate ``setup_*`` function at the end of the file.  Default:
  :code:`setup_home`.
- Set :code:`ONLY_EXPORT_PATHS` variable to 1, if we want to export the
  environment variables without creating the paths.
- Set :code:`PREFIX` variable, if required.  Default: :code:`$HOME`
  (environment variable).
- Set :code:`DRY_RUN` to 1 to check what changes the script would make.  (No
  changes are made during dry run.)


************
System Setup
************

I use the following software on all systems.  

Some of these software are dependencies of different dotfiles (in which case
the dependency is listed in the "Used by" column).

.. list-table:: System Softwares (All Systems)
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Software
     - Used by
     - Installation Source
     - Notes

   * - ``tmux``
     - .
     - System's package manager.
     - ``tmux`` dotfiles provided by this repository.  Please see 
       `Dotfiles Provided`_.

   * - ``curl`` and ``wget``
     - .
     - System's package manager
     - .

   * - ``ranger``
     - ``sr`` alias
     - System's package manager
     - ranger is an advanced CLI based file browser with vim-like keybinding
       and Mac-like interface.

   * - `Syncthing <https://syncthing.net/downloads/>`__
     - File sync/share, sync GTD, backup
     - System's package manager.
     - Setup Syncthing using the `Web GUI <http://127.0.0.1:8384>`__-

       - Set "Settings > General > Device Name"
       - Set "Settings > General > Default Folder Path" to
         :file:`~/public/file-share/`
       - Disable "Settings > Connections > Enable Relaying"
       - Add required devices using the correct device ID.
       - Add required folders using the correct folder ID.  Usually, i add-

         - :file:`~/private`
         - :file:`~/public` (:file:`.stignore` is checked-in)
         - :file:`~/resources` (:file:`.stignore` is checked-in)
         - One for each workspace

   * - (Neo)Vim
     - ``e`` alias
     - Systems's package manager.
     - See `Install NeoVim`_.  ``vim`` dotfiles provided by this repository.
       Please see `Dotfiles Provided`_.

   * - Pandoc
     - ``rst2slack.sh``
     - Systems's package manager.
     - This is required by utility scripts (like ``rst2slack.sh``) to convert
       between documentation formats.

   * - Docker
     - BASH dotfiles (several features)
     - Systems's package manager.
     - .

   * - Anaconda/Miniconda Python Distribution
     - Python Alias Space
     - `Anaconda <https://docs.anaconda.com/anaconda/install/>`__/
       `Miniconda <https://docs.conda.io/en/latest/miniconda.html>`__.

       For example, download the Miniconda installation script and execute as
       follows::

          # Replace the ".sh" file with the one for you OS
          # https://docs.conda.io/en/latest/miniconda.html
          bash Miniconda3-latest-MacOSX-x86_64.sh -b -p $DOTFILES_SOFTWARE_STANDALONE/miniconda3

       Create Conda environments and install packages as required.

     - No need to initialise Miniconda.  This can be done by calling
       ``act_conda`` (Defined in the Python Alias Space).

       I prefer Miniconda.

   * - Python
     - Python Alias Space
     - Systems's package manager.  Alternatively install from sources as
       mentioned in `Install Python (from sources)`_.
     - .

   * - `SDKMAN <https://sdkman.io/>`__
     - BASH JVM related alias spaces
     - curl -s "https://get.sdkman.io" | bash
     - Add the following to :file:`~/.profile`::

          export SDKMAN_DIR="~/.sdkman"
          [[ -s "~/.sdkman/bin/sdkman-init.sh" ]] && source "~/.sdkman/bin/sdkman-init.sh"

       SDKMAN adds these to :file:`~/.bash_profile`.  However, when
       :file:`.bash_profile` file is present, it prevents execution of
       :file:`.profile`.  Hence, remove the :file:`.bash_profile` file.

   * - Java Development Kit (JDK)
     - System and several utilities
     - SDKMAN
     - .

   * - Golang
     - Go Alias Space
     - From sources.  See `Install Go (from sources)`_.
     - .

   * - Node.js and NPM
     - .
     - System's package manager.
     - .

   * - yarn (Node.js)
     - Node.js.
     - ::

          sudo npm install -g yarn
          yarn —version
     - .

   * - `KeepassXC <https://keepassxc.org/download/>`__
     - Password manager.
     - System's package manager.
     - .

   * - Nginx
     - .
     - System's package manager.
     - .

   * - `Freeplane <https://sourceforge.net/projects/freeplane/>`__
       (Deprecated)
     - ``gtd`` alias in home.sh; GTD workflow
     - System's package manager.
     - If required, configure Freeplane as follows:

       - Create template

       - Config

         - Env

           - "Save folding" "if map is changed"

         - Behaviour

           - Disable "Fold on click inside"
           - "On key type": "Do nothing"
           - "Selection method": "By click"

       - Tools > Assign Hotkeys

         - <Tab> to "Create new child node"
         - Icons: C for check mark; X for cross mark; Z for questions mark

       If the version of Freeplane provided by the system's package manager is
       old, then please install the latest version of Freeplane using the
       binary package provided at the `Freeplane SourceForge page
       <https://sourceforge.net/projects/freeplane/>`__.

   * - Anki
     - .
     - System's package manager
     - https://apps.ankiweb.net

       Install addons-

       - `Colorful Tags (+ Hierarchical Tags)
         <https://ankiweb.net/shared/info/594329229>`__: 594329229
       - `Image Occlusion Enhanced
         <https://ankiweb.net/shared/info/1374772155>`__: 1374772155
       - `Review Heatmap <https://ankiweb.net/shared/info/1771074083>`__:
         1771074083
       - `Syllabus - Anki Statistics and Export by Tag and Deck
         <https://ankiweb.net/shared/info/668156440>`__: 668156440
       - `Syntax Highlighting for Code
         <https://ankiweb.net/shared/info/1463041493>`__: 1463041493
       - `True Retention <https://ankiweb.net/shared/info/613684242>`__:
         613684242

       Import your old Anki decks, if required.

   * - Zotero
     - .
     - System's package manager
     - Configure Zotero as follows:

       - Set "Preferences > Advanced > Data Directory Location" to
         :file:`~/private/zotero/`
       - If required, turn OFF Syncing in "Preferences > Sync".

   * - FireFox/Web Browser
     - .
     - System's package manager
     - Addons/plugins-

       - Tridactly (vi-like interface to browser): https://addons.mozilla.org/en-US/firefox/addon/tridactyl-vim/
       - Dark Reader (dark mode on all websites): https://addons.mozilla.org/en-US/firefox/addon/darkreader/
       - Tab Session Manager (save and restore tabs and session): https://addons.mozilla.org/en-US/firefox/addon/tab-session-manager/
       - Enable Bing Chat (to send Edge's User-Agent): https://addons.mozilla.org/en-US/firefox/addon/enable-bing-chat/
       - ChatGPTBox (integrate AI chatbots into the browser): https://addons.mozilla.org/en-US/firefox/addon/chatgptbox/
       - stutter (RSVP for browsers): https://github.com/jamestomasino/stutter
       - Zotero Connector: https://www.zotero.org/
       - Okta Browser plugin?

       Bookmarks: Search (add keyword)-
       
       - reddit: :code:`https://www.reddit.com/search/?q=%s`
       - youtube: :code:`https://www.youtube.com/results?search_query=%s&page={startPage?}&utm_source=opensearch`
       - sklearn: :code:`https://scikit-learn.org/stable/search.html?q=%s`
       - pd: :code:`https://pandas.pydata.org/docs/search.html?q=%s`
       - git: :code:`https://github.com/search?q=%s`
       - man: :code:`https://duckduckgo.com/?va=p&t=hd&q=%s+site%3Ahttps%3A%2F%2Fwww.man7.org&ia=web`
       - jash: :code:`http://localhost:8080/ashim/search.html?q=%s`
       - jkno: :code:`http://localhost:8080/knowl/search.html?q=%s`
       - jcli: :code:`http://localhost:8080/clinic/search.html?q=%s`
       - jfam: :code:`http://localhost:8080/family/search.html?q=%s`

       Bookmarks: apidocs-

       - `scala <https://www.scala-lang.org/api/2.11.12/#package>`__ (2.11.12)
       - `spark-scala <https://spark.apache.org/docs/2.3.0/api/scala/index.html#org.apache.spark.package>`__
       - `pandas <https://pandas.pydata.org/docs/reference/index.html>`__
       - `sklearn <https://scikit-learn.org/stable/modules/classes.html>`__
       - `matplotlib <https://matplotlib.org/stable/api/index.html#the-object-oriented-api>`__
       - `numpy <https://numpy.org/doc/stable/reference/index.html>`__
       - `pyspark
         <https://spark.apache.org/docs/2.3.0/api/python/index.html>`__
       - `tensorflow <https://www.tensorflow.org/api_docs/python/tf/keras>`__
       - `go <https://pkg.go.dev/%s>`__
       - `gopkg <https://pkg.go.dev/search?q=%s>`__
       - `goeg <https://duckduckgo.com/?q=\%s+site:gobyexample.com>`__

       Bookmarks: tools-

       - `sql-validator
         <https://www.eversql.com/sql-syntax-check-validator/>`__
       - `json-ed <https://jsoneditoronline.org/>`__
       - `jsondiff <https://jsondiff.com/>`__
       - `Optimizilla <https://imagecompressor.com/>`__
       - `Mathcha <https://www.mathcha.io/editor>`__
       - `latex-math-ed <https://latexeditor.lagrida.com/>`__

       Bookmarks: misc-

       - `Syncthing <http://127.0.0.1:8384/>`__
       - `local-yarn-rm-ui <http://localhost:8088/cluster/scheduler>`__
       - `local-jupyter <http://localhost:8888/tree>`__

   * - Metabase
     - .
     - System's package manager.
     - Used to analyse data in DB.  After installation, immediately migrate
       application database from embedded H2 DB to external DB (like MySQL).

   * - ``tree``
     - .
     - System's package manager
     - .

   * - ``jq``
     - Various utilities (base.sh)
     - Systems's package manager.  `Website
       <https://stedolan.github.io/jq/>`__.
     - .

   * - ``vlc``
     - .
     - System's package manager
     - .

   * - Powerline Pached Fonts
     - ``tmux``
     - .
     - Please see README in tmux dotfiles: `Dotfiles Provided`_.

   * - Font: Source Code Pro
     - .
     - System's package manager.

       On Mac OS (using brew)::

          brew tap homebrew/cask-fonts
          brew install font-source-code-pro

     - This is a great font for the terminal.

   * - Graphviz/dot
     - .
     - System's package manager.
     - .


.. list-table:: System Softwares (Linux-only)
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Software
     - Used by
     - Installation Source
     - Notes

   * - ``xclip``
     - ``scc`` and ``spc`` aliases in base.sh
     - Systems's package manager.  Repo: `astrand/xclip
       <https://github.com/astrand/xclip>`__
     - .

   * - redshift
     - .
     - System's package manager
     - Add to Startup Applications.

   * - CopyQ
     - .
     - System's package manager
     - Clipboard manager.  Add to Startup Applications.  Configure <C-M-v> as
       trigger/hot key.


.. list-table:: System Softwares (Mac-only)
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Utility
     - Used by
     - Installation Source
     - Notes

   * - ``brew``
     - Various BASH dotfiles.
     - `Homebrew website <https://brew.sh/>`__
     - Follow instructions provided after the script completes to complete the
       installation.

       Occurances of "system package manager" in this repo refers to Homebrew
       on Mac.

   * - Karabiner Elements
     - .
     - `Karabiner-Elements GitHub page
       <https://github.com/pqrs-org/Karabiner-Elements>`__
     - Add to Startup Applications.

   * - Jumpcut
     - .
     - System's package manager
     - Clipboard Manger.  Add to Startup Applications.


************
Python Setup
************

- Ensure Anaconda/Miniconda is installed as per `System Setup`_.


Install Python Utilities
========================

Ensure that the following are also installed

- Python3: If system does not have Python3, either install using system's
  package manager, activate Conda's Python installation, or `Install Python
  (from sources)`_ as detailed below.

  Mac OS's Python3 has some issues: see `this
  <https://stackoverflow.com/a/64946518>`__.  Hence, install python3 via brew.

- Python2: Python3 has pip and virtualenv built-in.  However, for Python2,
  these must be installed.

  - ``pip``: Install using `get-pip.py
    <https://pip.pypa.io/en/stable/installing/#installing-with-get-pip-py>`__

    For Mac OS::

       sudo easy_install pip
       sudo pip install --ungrade pip

  - ``virtualenv``::

      pip install virtualenv
      sudo /usr/bin/easy_install virtualenv  # For Mac OS


Install Python (from sources)
=============================

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
===================================

Setup Python virtual enviroments (for ``dve``)::

  export DOTFILES=$HOME/.dotfiles/bash/
  source $DOTFILES/utils/path-info.sh

  # First setup nvimpy2.  It needs Python 2.  So use -p to point to a Python 2
  cd "$DOTFILES_PYENVS" && \
    virtualenv -p /usr/bin/python nvimpy2 && \
    cd nvimpy2 && \
    source bin/activate && \
    mv '../nvimpy2.requirements.txt' requirements.txt && \
    pip install -r requirements.txt

  # Then setup Python 3 virtual envs.
  # (On Ubuntu, ensure that python3-venv is installed-
  # sudo apt install python3-venv)
  cd "$DOTFILES_PYENVS" && \
    ls *.requirements.txt | \
    xargs -I '{}' bash -c "echo '{}' | cut -d. -f1" | \
    xargs -I '{}' bash -c "python3 -m venv '{}' && cd '{}' && source bin/activate && mv '../{}.requirements.txt' requirements.txt && pip install -r requirements.txt"

.. note::
   If you get "Could not find a version that satisfies the requirement" error,
   try changing the version of the problematic package in the problematic
   :file:`DOTFILES_PYENVS/*.requirements.txt` file.


**************
(Neo)Vim Setup
**************

We might get the following errors on macOS's default vim::

   LeaderF requires Vim compiled with python and/or a compatible python version.
   UltiSnips requires py >= 2.7 or py3


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
follows (these are already done when you checkout this repo and run
:file:`setup-folders.sh`):

- Create a separate virtualenv and install ``pynvim``.
- Update ``~/.config/nvim/init.vim``::

    let g:python_host_prog="$DOTFILES_PYENVS/nvimpy2/bin/python"
    let g:python3_host_prog="$DOTFILES_PYENVS/nvim/bin/python3"


********
Go Setup
********

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


*************
Crontab Setup
*************

None.


*******************
Repository Overview
*******************

Dotfiles Provided
=================

Please find the details of the dotfiles provided by this repository.

.. list-table:: Dotfiles Provided
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Dotfiles
     - Documentation
     - Notes

   * - BASH
     - :file:`.dotfiles/bash/`
     - 

   * - tmux
     - :file:`.dotfiles/tmux/`
     -

   * - Git
     - :file:`.dotfiles/git/`
     -

   * - Vim
     - :file:`.dotfiles/vim/`
     - 

   * - NeoVim
     - :file:`.dotfiles/vim/`, :file:`$HOME/.config/nvim/init.vim`
     -

   * - Ctags
     - :file:`.dotfiles/ctags/`
     -

   * - Window Manager
     - :file:`.dotfiles/wm/`
     - 

   * - Knowledge bases
     - :file:`.dotfiles/knowl/`
     - + Nginx localhost configuration:
         :file:`.dotfiles/knowl/nginx-localhost.conf` (update paths as per need)
       + :file:`.dotfiles/knowl/index.html`
       + :file:`.dotfiles/knowl/phpinfo.php`

       :file:`index.html` and :file:`phpinfo.php` are copied to path in
       :code:`$DOTFILES_WWW` env var.

   * - Data Backups
     - :file:`.dotfiles/backups/`
     - Design and resources for data sync and backup (including to cloud).

Utilities Provided
==================

Please find the details of the utilities provided in this repository as follows.

.. list-table:: System Utilities Provided
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Utility
     - Notes

   * - trashit.sh
     - ``rm`` is aliased to trashit.sh to ensure that we move files to the
       trash instead of deleting it.

   * - sqlout2csv.py
     - A python executable to convert output text of SQL queries to CSV.  It
       is copied into the path by setup-folders.sh.

       Reads text of SQL queries from stdin.  Prints CSV to stdout.

       USAGE::

          $ cat sqlout.txt
          +-------+--------+
          |cmpg_id|BucketId|
          +-------+--------+
          |22918  |0       |
          |22918  |1       |
          |22918  |2       |
          |22987  |12      |
          +-------+--------+
          only showing top 4 rows

          $ cat sqlout.txt | sqlout2csv.py
          cmpg_id,BucketId
          22918,0
          22918,1
          22918,2
          22987,12

   * - tsv2csv.sh
     - Shell script to convert TSV to CSV.  It is copied into the path by
       setup-folders.sh.

       Reads TSV from stdin.  Prints CSV to stdout.

       USAGE::

          $ cat test.tsv
          14      Jyoti
          18      Ashim

          $ cat test.tsv | tsv2csv.sh
          "14","Jyoti"
          "18","Ashim"

   * - is-repo-dirty.sh
     - List all dirty Git repo under specified paths.  It is copied into the
       path by setup-folders.sh.

       Update paths variable in code.

       USAGE::

          $ is-repo-dirty.sh
          /Users/ashim/ashim//projbg/kaizen/.git
          /Users/ashim/private/gtd//.git
          /Users/ashim/.dotfiles.git/

   * - make-proj-dirs.sh
     - Create project scaffolding for data science/ML projects.

       USAGE::

          bash make-proj-dirs.sh <artifact-type> <artifact-name>

       where-

       - artifact-type is one of: proj, ana, model, deploy, deploy_ana,
         deploy_model
       - artifact-name: Name of artifact
       
       EXAMPLE::

          bash make-proj-dirs.sh ana lift-ana

   * - sync-proj-todos.sh
     - Copy project todos.org files to orgzly folder.  This is required so
       that these files are available on the mobile Orgzly.

       USAGE::

          sync-proj-todos.sh

   * - painlessmerge.sh
     - Required by :file:`$HOME/.gitconfig`.

   * - jsbeautify.py
     - Used in JavaScript Alias Space.

   * - ``rst2slack.sh``
     - Convert ReStructuredText (rst) format to Slack Markdown format.

       Usage::

          echo "Test :code:\`x=y\`" | rst2slack.sh

       Provide the input text in ``stdin``.  The output is printed to
       ``stdout`` and copied to the system clipboard.

       Note: ``rst2slack.sh`` will be installed into the ``PATH`` by
       ``setup-folder.sh``.

   * - Python Virtual Environments
     - Python Virtual Environments are stored in
       :file:`.dotfiles/resources/pyenvs/`.


Repository Creation
===================

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


Repository Conventions
======================

- All Dotfiles are documented in a ``README.rst`` in the same folder as the
  dotfile.

  - See :file:`.dotfiles/bash/README.rst`.

- Key paths are stored in environment variables having the form $DOTFILES_*.
  For example, install software from source in the prefix
  $DOTFILES_SOFTWARE_INSTALL_PREFIX.  These variables are exported in
  path-info.sh.  (path-info.sh is generated by setup-folders.sh).

.. TODO: List out all conventions


*************
 Future Work
*************

- In setup-folders.sh-

  - Fix errors during DRY_RUN
  - Ensure no state changes during DRY_RUN

- Update chunkwm to yabai
- Creating scaffolding for new project (use Yeoman?)
- Can we use rg instead of grep?
- mutt setup???
- TODO: Golang: org. and add util dir
- Add go workspace dir hierarchy?
- Add ~/.npmrc?
- TODO: Create SSH keys (any other keys?)
- Should we deprecate building Python and Vim from sources.  This was only
  required for distros that didn't ship with Python 3 enabled in Vim?
- Document vim dotfiles in .dotfiles/vim/README.rst
- Get venvs working on linux and mac

- Deprecate Freeplane?

====

- Check-in

  - .vim/bundle/firenvim
  - tmux: create a Github fork of tmux-config so that I can track my custom
    changes. See diff for custom changes::

       diff ~/.tmux/tmux.conf ~/dotfiles/tmux/tmux-config/tmux/tmux.conf

  - ~/.dotfiles/vim/vimonly.vim
  - Spacemacs

    - Add to setup-folders.sh: cd /Users/ashimghosh/.emacs.d && rm private && ln -s ~/.dotfiles/spacemacs/private/
    - Add README/folder for spacemacs.

