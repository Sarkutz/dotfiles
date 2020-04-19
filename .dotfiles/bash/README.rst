
#############
BASH Dotfiles
#############

.. contents::

************
Dependencies
************

- Ensure that :file:`${DOTFILES}/utils/path-info.sh` is setup (this file is
  created by :file:`${DOTFILES}/utils/setup-folders.sh`).


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
     - Paste from Clipboard.
       Usage::

         spc

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

   * - ``dgd``
     - ``base.sh``
     - Perform grep on a directory.
       Usage::

         dgd <dirname>

   * - ``dtag``
     - ``base.sh``
     - Create tags for code navigation.
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
       - "future": Find for search_pattern in future/ and jump to matching dir

       Supports completions for ``command`` and ``search_pattern`` (in
       ``future``).

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

   * - ``jme``
     - ``home.sh``
     - Jump to me workspace directory.
       Usage::
       
          jme [searchterm]

          If ``searchterm`` is provided, ``find`` for path that matches
          ``*searchterm*``.'

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

- $DOTFILES_SOFTWARE_STANDALONE/spark-2.4.0-bin-hadoop2.7/bin should be installed

Commands
--------

- Add $DOTFILES_SOFTWARE_STANDALONE/spark-2.4.0-bin-hadoop2.7/bin to PATH

.. list-table:: Scala Alias Space Commands
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Command
     - Location
     - Description

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

   * - ``prefix_unique``
     - Prefix to `text` only if `prefix` does not already exist in the string.  Syntax::

         prefix_unique <text> <prefix> <delim>'

   * - ``suffix_unique``
     - Suffix to `text` only if `suffix` does not already exist in the string.  Syntax::

         suffix_unique <text> <suffix> <delim>'

   * - ``prefix_to_path``
     - Add path as the first entry in PATH env. var.  (NOTE: Updates the PATH env. var.)  Syntax::

         prefix_to_path <path-to-prefix>'

   * - ``remove_from_path``
     - Remove a path from PATH env. var.  (NOTE: Updates the PATH env. var.)  Syntax::

         remove_from_path <path-to-remove>'

   * - ``start_singleton``
     - Start the specified process only if it is not already running.  Syntax::

         start_singleton <proc> [as_su]'

   * - ``will_overwrite``
     - Check if `source_path` might overwrite `dest_path`.  Syntax::

         will_overwrite <source_path> <dest_path>'

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

         rest es GET /_cat/indices?v'

       Supports completions for ``api-id``.

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

- ``utils``: Contains utilities useful to manage this project.


*************
 Future Work
*************

