
#############
BASH Dotfiles
#############

.. contents::

************
Dependencies
************

- Ensure that :file:`${DOTFILES}/utils/path-info.sh` is setup (this file is
  created by :file:`${DOTFILES}/utils/setup-folders.sh`).

.. list-table:: Dependencies
   :widths: auto
   :header-rows: 1

   * - Dependency
     - Used by
     - Installation Source
     - Notes

   * - ctags
     - ``dtag`` alias
     - System's package manager
     - On Mac OS install using brew as the version provided by default does
       not support required arguments::

          brew install ctags

   * - peco
     - jd alias in ``base.sh``
     - System's package manager.
     - .

- Also install dependencies for each, required alias space (see below).


*********************
Install BASH Dotfiles
*********************

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

Note update the ``source`` command to source appropriate file as per
target enviroment.

::

  source ~/.profile


**********
 Commands
**********

Class Prefix
============

All commands are classified under following classes.  Each command is prefixed
with a single character according to the class it falls under.  The classes
and their prefixes are as follows:

- Misc/All (Prefix: ``a``)
- System (Prefix: ``s``)
- Development (Prefix: ``d``)
- ``fg`` (Prefix: ``f``)
- Jump (goto location) (Prefix: ``j``)
- Tools/Kit (Prefix: ``k``)
- ls related (Prefix: ``l``)

Misc/All
--------

.. list-table:: Misc/All Commands
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Command
     - Location
     - Description

   * - ``slackm``
     - ``base.sh``
     - Send ``message`` as a Slack notification.  It sends the notification
       to the  Slack incomming webhook URL in
       ``$SECRET_SLACK_INCOMMING_WEBHOOK_URL``.
       Usage::

          slackm <message>

       Example::

          # export "SECRET_SLACK_INCOMMING_WEBHOOK_URL=..."
          slackm "notify me about this"

        Note: message is sent as a JSON string.

   * - ``amxs``
     - ``base.sh``
     - Send message as a Matrix notification.  Usage::

          export "SECRET_MATRIX_PASSWORD=..."
          amxs "message"

       Pre-condition: Env var SECRET_MATRIX_PASSWORD must be set to a valid
       matrix user password.

   * - anoti
     - ``base.sh``
     - Send notification based on return value of previous command to Matrix
       room.  Usage::

          cat foo
          anoti "Success message" "Fail message"

       Pre-condition: pre-conditions for amxs are met.

   * - ``agtd``
     - ``home.sh``
     - Start GTD resources.

System
------

.. list-table:: System Commands
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Command
     - Location
     - Description

   * - ``sj``
     - ``base.sh``
     - ``jobs``

   * - ``sps``
     - ``base.sh``
     - Process Search.
       Usage::

         sps <process-name-substring>

       List all processes whose name matches ``process-name-substring``.

   * - ``scc``
     - ``base.sh``
     - Copy to Clipboard.
       Usage::

         echo 'copy this' | scc

   * - ``spc``
     - ``base.sh``
     - Paste to Clipboard.
       Usage::

         spc

   * - ``scg``
     - ``base.sh``
     - Copy to Global Clipboard.
       Usage::

         echo 'copy this' | scg

   * - ``spg``
     - ``base.sh``
     - Paste to Global Clipboard.
       Usage::

         spg

   * - ``tmuxpl``
     - ``base.sh``
     - tmuxp: Load tmux session from ``.tmuxp.yaml`` in the current folder.
       Usage::

          tmuxpl

   * - ``tmuxpf``
     - ``base.sh``
     - tmuxp: Save (freeze) tmux session to ``.tmuxp.yaml`` (overwrite if
       existing) in the current folder.  Usage::

          tmuxpf

   * - ``sr``
     - ``home.sh``
     - Start ranger (file browser).  Usage::

          sr

   * - ``so``
     - ``home.sh``
     - Open file/directory using ``open`` (which detects the appropriate
       software).  Only for Mac OS.  Usage::

          so <file/dir>

   * - ``set_window_title``
     - ``base.sh``
     - Set title of BASH window (by setting PROMPT_COMMAND).  Usage::

          set_window_title "Window Title"

Development
-----------

.. list-table:: Development Commands
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Command
     - Location
     - Description

   * - ``e``
     - ``base.sh``
     - Open editor (specified in $EDITOR).
       Usage::

         e [filename]

   * - ``dvi``
     - ``base.sh``
     - Check open VI.

   * - ``dpy``
     - ``base.sh``
     - Alias for opening Python bin.

   * - ``dgd``
     - ``base.sh``
     - Perform grep on a directory.
       Usage::

         dgd <dirname>

   * - ``dcc``
     - ``base.sh``
     - Fuzzy find through list of (common) commands specified in
       ``./commands.cli`` or ``~/commands.cli`` then execute the selected
       command.  Usage::

          dcc

   * - ``dtag``
     - ``base.sh``
     - Create tags for code navigation.  It creates ctags and cscope.
       Usage::

         dtag


fg (f)
------


Jump
----

.. list-table:: Jump Commands
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Command
     - Location
     - Description

   * - ``jgtd``
     - ``home.sh``
     - Jump to GTD directory.
       Usage:: 
       
         jgtd [command]

       where ``command`` can be-

       - "tickler": Jump to todays tickler directory.'
       - "dreams": Find for search_pattern in dreams/ and jump to matching dir

       Supports completions for ``command`` and ``search_pattern`` (in
       ``dreams``).

   * - ``jkno``
     - ``home.sh``
     - Jump to knowl directory.
       Usage::

         jkno [searchterm]

         If ``searchterm`` is provided, ``find`` for path that matches
         ``*searchterm*``.'

       Completion supported.

   * - ``jdia``
     - ``home.sh``
     - Jump to diary
       Usage::

         jdia

   * - ``jash``
     - ``home.sh``
     - Jump to ashim workspace directory.
       Usage::
       
          jash [searchterm]

       If ``searchterm`` is provided-

       #. Find for a project named ``searchterm`` and jump to it.
       #. Find for ``searchterm`` using ``find_and_jump`` and jump to it.

       Completion supported.

   * - ``jcli``
     - ``home.sh``
     - Jump to clinic workspace directory.
       Usage::
       
          jcli [searchterm]

       If ``searchterm`` is provided-

       #. Find for a project named ``searchterm`` and jump to it.
       #. Find for ``searchterm`` using ``find_and_jump`` and jump to it.

       Completion supported.

   * - ``jfam``
     - ``home.sh``
     - Jump to family workspace directory.
       Usage::
       
          jfam [searchterm]

       If ``searchterm`` is provided-

       #. Find for a project named ``searchterm`` and jump to it.
       #. Find for ``searchterm`` using ``find_and_jump`` and jump to it.

       Completion supported.

Tool/Kit
--------

.. list-table:: Tool/Kit Commands
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Command
     - Location
     - Description

   * - ``kd``
     - ``base.sh``
     - Shortcut for ``sudo docker``
   * - ``km``
     - ``base.sh``
     - Shortcut for ``sudo minikube``
   * - ``kk``
     - ``base.sh``
     - Shortcut for ``sudo kubectl``

   * - ``toggle_server``
     - ``obsoleted.sh (from ``home.sh``)
     - Obsoleted.  Quick switch between apache and nginx
   * - ``restart_server``
     - ``obsoleted.sh (from ``home.sh``)
     - Obsoleted.  Restart running apache or nginx
   * - Email Toolchain
     - ``obsoleted.sh (from ``home.sh``)
     - Obsoleted.  ``run_offlineimap``, ``syncmail``

   * - ``kdfgit``
     - ``base.sh``
     - Manipulate the Git bare repo containing all dotfiles.


ls Related
----------

.. list-table:: ls Related Commands
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Command
     - Location
     - Description

   * - ``l``
     - ``base.sh``
     - Shortcut for ls

   * - ``ll``
     - ``base.sh``
     - List Less.  Lists ten most recent files.


Overrides
=========

.. list-table:: Overridden Commands
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Overridden Command
     - Location
     - Description

   * - ``rm``
     - ``base.sh``
     - Move file to ~/.Trash instead of deleting it.

       Alias to ``./trashit.sh``.

   * - ``cp``
     - ``base.sh``
     - If the copy would overrite a file in the destination, 
       print an error and return without copying.

   * - ``mv``
     - ``base.sh``
     - If the move would overrite a file in the destination, 
       print an error and return without moving.

   * - ``diff``
     - ``base.sh``
     - Always using unified diff (``-u`` flag).


**************
 Alias Spaces
**************

Alias Spaces are namespaces of aliases, functions and commands, that can be
activated and deactivated.

There are very useful for shortcuts that are only useful for a particular
domain.  For example, it's useful to set GOPATH only for Go development.

In such cases, Alias Spaces allows enabling domain-specific commands
temporaraly.  Once work is done we can disabled the Alias Space.

Multiple Alias Spaces can be active at the same time.  Check the
``$DOTFILES_ALIAS_SPACES`` env. var. to see which Alias Spaces are active.

Use ``act_foo_alias_space`` to activate the ``foo`` Alias Space and
``deact_foo_alias_space`` to deactivate it.


C Alias Space
=============

TODO

Dependencies
------------

Commands
--------


Python Alias Space
==================

Dependencies
------------

- Ensure Python 3 is installed and the binary is available in the $PATH.
- Ensure Virtual Environments are installed at ``$DOTFILES_PYENVS``.
- ``jsbeautifier`` module (required for ``kjsb``): pip install jsbeautifier
- Before using ``toconflu`` function, ensure that ``sphinx_build`` is in the
  path.  The Sphinx project must have ``sphinxcontrib.confluencebuilder``
  Sphinx extension installed and configured.

Commands
--------

.. list-table:: Python Alias Space Commands
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Command
     - Location
     - Description

   * - ``python_venv_activate``
     - ``dev.sh`` (Python Alias Space)
     - Activate ``env_name`` Python Virtual Environment.  Usage::

         python_venv_activate <env-name> [env_dir]

       - ``env_name``: Name of venv folder
       - ``env_dir`` (optional): Path to the directory containing the virtual
         environment (default: ``$DOTFILES_PYENVS``)

       Supports completions for virtual environment name (only for virtual
       environments in ``$DOTFILES_PYENVS``).

   * - ``toconflu``
     - ``dev.sh`` (Python Alias Space)
     - Convert specified Sphinx path to Confluence storage format and copy it
       to the clipboard.  This must be executed from the directory containing
       Sphinx's Makefile.  Usage::

          toconflu sphinx/path/to/file/wo/ext

       Example::

          toconflu projfg/foo/doc/conflu/proj-dash


Java Alias Space
================

TODO

Dependencies
------------

Commands
--------

.. list-table:: Java Alias Space Commands
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Command
     - Location
     - Description

   * -
     -
     -


Scala Alias Space
=================

TODO

Dependencies
------------

- Hadoop should be installed at
  :file:`$DOTFILES_SOFTWARE_STANDALONE/hadoop-3.3.0/bin`.
  See `Hadoop: Setting up a Single Node Cluster
  <https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html>`__
  for setting up Hadoop and YARN in Pseudo-Distributed Mode.

- Spark should be installed and in PATH.  Install using SDKMAN:
  :code:`sdk install spark`.

Commands
--------

- Activate `Java Alias Space`_

- Add $DOTFILES_SOFTWARE_STANDALONE/spark-2.4.0-bin-hadoop2.7/bin to PATH

.. list-table:: Scala Alias Space Commands
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Command
     - Location
     - Description

   * - ``$HADOOP_HOME``
     - ``dev.sh``
     - :file:`$DOTFILES_SOFTWARE_STANDALONE/hadoop-3.3.0/`.
       :file:`$HADOOP_HOME/bin` is added to PATH.

   * - ``$HADOOP_CONF_DIR``
     - ``dev.sh``
     - :file:`$HADOOP_HOME/etc/hadoop/`.

   * - ``start_cluster``
     - ``dev.sh``
     - Start Spark (and Hadoop) cluster.  Source:

       - NameNode: http://localhost:9870/
       - ResourceManager: http://localhost:8088/

       Getting :code:`ssh: Could not resolve hostname` is not an issue.

       If NN doesn't start (see logs) try::

          hdfs namenode -format

   * - ``stop_cluster``
     - ``dev.sh``
     - Stop Spark (and Hadoop) cluster.

   * - ``dnew_spark_proj``
     - ``dev.sh``
     - Alias to create a new Spark Scala project using Giter8 template from
       https://github.com/Sarkutz/spark-scala.g8 .


Go Alias Space
==============

Dependencies
------------

- Go installed at prefix ``${HOME}/go`` by building from sources.

Commands
--------

- Adds Go binary (which was built from sources) to the PATH.
- Adds ``${DOTFILES_REPOS}/go/bin/`` to PATH.
- Exports GOPATH

.. list-table:: Go Alias Space Commands
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Command
     - Location
     - Description

   * - ``goplay``
     - ``dev.sh``
     - Function to open Go runtime in Docker for quick experiments in Golang.


R Alias Space
=============

TODO

Dependencies
------------

Commands
--------


JavaScript Alias Space
======================

TODO

Dependencies
------------

Commands
--------

.. list-table:: JavaScript Alias Space Commands
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Command
     - Location
     - Description

   * - ``jspp``
     - ``dev.sh`` (JavaScript Alias Space)
     - JS Pretty Print (JS Beautifier).  Alias to jsbeautify.py.

   * - ``jsplay``
     - ``dev.sh``
     - Function to open a test website in Docker for quick experiments on
       basic web development.


*******************
 Utility Functions
*******************

Utility functions are implemented in :file:`utils/bashrc-utils.sh` and
:file:`utils/bashrcutils.py`.

.. list-table:: Utility Function (BASH)
   :widths: auto
   :header-rows: 1

   * - Function Name
     - Usage

   * - ``get_os``
     - Print OS of system.  Output values-

       - ``mac_os``: Mac OS

       Syntax::

          get_os

   * - ``prefix_unique``
     - Prefix to `text` only if `prefix` does not already exist in the string.  Syntax::

         prefix_unique <text> <prefix> <delim>

   * - ``suffix_unique``
     - Suffix to `text` only if `suffix` does not already exist in the string.  Syntax::

         suffix_unique <text> <suffix> <delim>

   * - ``prefix_to_path``
     - Add path as the first entry in PATH env. var.  (NOTE: Updates the PATH env. var.)  Syntax::

         prefix_to_path <path-to-prefix>

   * - ``remove_from_path``
     - Remove a path from PATH env. var.  (NOTE: Updates the PATH env. var.)  Syntax::

         remove_from_path <path-to-remove>

   * - ``get_num_lines``
     - Return the number of lines in the provided input.  Syntax::

          get_num_lines <text>

   * - ``get_num_lines``
     - Return the number of lines in the provided input.  Syntax::

          get_num_lines <text>

   * - ``start_singleton``
     - Start the specified process only if it is not already running.  Syntax::

         start_singleton <proc> [as_su]

   * - ``will_overwrite``
     - Check if `source_path` might overwrite `dest_path`.  Syntax::

         will_overwrite <source_path> <dest_path>

   * - ``rest``
     - Make HTTP calls to REST HTTP endpoints.  Syntax::

         rest <api-id> <http-method> <uri-path> [post-data]

       where-

       - `api-id`: Identifies the REST endpoint.  Values-

         - es: ElasticSearch on localhost
         - kib: Kibana on localhost
         - Any valid HTTP endpoint

       - `post_data`: ASSUME: Post data is in JSON format.

       Example::

         rest es GET /_cat/indices?v

       Supports completions for ``api-id``.

   * - :code:`find_and_jump`
     - Find path matching search_term under find_root, and jump to it if
       single matching path is found.  Syntax::

          find_and_jump <find_root> <search_term>

       First find for path that matches ``search_term`` exactly.

       - If a single path is found then jump to it.
       - If multiple paths are found then print all paths and return.
       - If no path is found then repeat this process with a substring match
         (``*search_term*``).

   * - :code:`is_ranger_shell`
     - Are we inside a shell created by ranger?  Syntax::

          is_ranger_shell

       Return value-

       - 1: Inside shell created by ranger.
       - 0: otherwise'


.. list-table:: Utility Function (Python)
   :widths: auto
   :header-rows: 1

   * - Function Name
     - Usage

   * - ``remove_token``
     - From a ``text`` string consisting of multiple tokens separated by
       ``sep`` character, remove ``token`` from the list.  Example::
  
        remove_token('a:b:c:b:d', 'b', ':')


*********************
 Directory Hierarchy
*********************

I organise my folders as follows::

   ~
   ├── Downloads
   ├── README.rst
   ├── private
   │   ├── active
   │   │   └── all.kdbx
   │   ├── gtd
   │   ├── orgzly
   │   ├── diary
   │   ├── knowl
   │   ├── anki
   │   ├── zotero
   │   └── ghosh-family
   ├── public
   │   ├── website
   │   │   ├── knowl -> /home/ashim/private/knowl/
   │   │   └── online
   │   │       ├── blog
   │   │       └── kbase
   │   └── www
   ├── resources
   │   ├── ashim
   │   ├── data
   │   ├── repos
   │   └── software
   │       ├── archive
   │       ├── installed
   │       ├── pyenvs
   │       └── standalone
   ├── archives    # Only active archives; inactives stored on ext HD
   │   ├──         # TODO: figure out hierarchy
   │   └── media (family photos etc.)
   ├── storage     # Only active storage; inactives stored on ext HD
   │   ├── movies
   │   └── songs
   ├── ashim
   ├── clinic
   └── family

We can create this folder hierarch using
:file:`${DOTFILES}/utils/setup-folders.sh`.  :file:`setup-folder.sh` also
sets-up :file:`${DOTFILES}/utils/path-info.sh` so that dotfiles can refer to
these paths using environment variables.


Directories in this folder-

- ``utils``: Contains utilities useful to manage this project.


*************
 Future Work
*************

