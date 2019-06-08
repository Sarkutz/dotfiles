
#############
BASH Dotfiles
#############

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

System
------

.. list-table::
   :caption: System Commands
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Command
     - Location
     - Description

   * - ``sps``
     - ``base.sh``
     - Process Search.
       Usage::

         sps <process-name-substring>

       List all processes whose name matches ``process-name-substring``.

   * - ``sj``
     - ``base.sh``
     - ``jobs``

Development
-----------

.. list-table::
   :caption: Development Commands
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

   * - ``dtag``
     - ``base.sh``
     - Create tags for code navigation.
       Usage::

         dtag

   * - ``dgd``
     - ``base.sh``
     - Perform grep on a directory.
       Usage::

         dgd <dirname>

   * - ``gtd``
     - ``home.sh``
     - Start GTD resources.

fg (f)
------


Jump
----

.. list-table::
   :caption: Jump Commands
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Command
     - Location
     - Description

   * - ``kdfgit``
     -
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

Tool/Kit
--------

.. list-table::
   :caption: Tool/Kit Commands
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

ls Related
----------

.. list-table::
   :caption: ls Related Commands
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

base.sh

rm -> trashit.sh
cp, mv -> check for overwrite
diff -> diff -u (unified diff)


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

.. list-table::
   :caption: Python Alias Space Commands
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Command
     - Location
     - Description

   * - ``python_venv_activate``
     - ``dev.sh`` (Python Alias Space)
     - Activate `env_name` Python Virtual Environment.  Usage::

         python_venv_activate <env-name>'

       Virtual Envs are searched at ``$DOTFILES_PYENVS``.

   * - ``dve``
     - ``base.sh``
     - Activate Python Virtual Environment.
       Usage::

         dve <venv-name>

       See ``python_venv_activate``. ::

         alias dve=python_venv_activate

   * -
     -
     -


Java Alias Space
================

TODO

Dependencies
------------

Commands
--------


Scala Alias Space
=================

TODO

Dependencies
------------

- $DOTFILES_SOFTWARE_STANDALONE/spark-2.4.0-bin-hadoop2.7/bin should be installed

Commands
--------

- Add $DOTFILES_SOFTWARE_STANDALONE/spark-2.4.0-bin-hadoop2.7/bin to PATH

.. list-table::
   :caption: Python Alias Space Commands
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Command
     - Location
     - Description

   * -
     -
     -


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

.. list-table::
   :caption: Python Alias Space Commands
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Command
     - Location
     - Description

   * - ``goplay``
     - ``home.sh``
     - Function to open Go runtime in Docker for quick experiments in Golang.

   * -
     -
     -


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

.. list-table::
   :caption: Python Alias Space Commands
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Command
     - Location
     - Description

   * - ``kjsb``
     - ``dev.sh`` (JavaScript Alias Space)
     - JS Beautifier.  Alias to jsbeautify.py.

   * - ``jsplay``
     - ``home.sh``
     - Function to open a test website in Docker for quick experiments on
       basic web development.

   * -
     -
     -


*******************
 Utility Functions
*******************

Utility functions are implemented in :file:`utils/bashrc-utils.sh`` and :file:`utils/bashrcutils.py`.

.. list-table::
   :caption: Utility Function (BASH)
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

       - `post_data`: ASSUME: Post data is in JSON format.

       Example::

         rest es GET /_cat/indices?v'

   * -
     -


.. list-table::
   :caption: Utility Function (Python)
   :widths: auto
   :header-rows: 1

   * - Function Name
     - Usage

   * - ``remove_token``
     - From a ``text`` string consisting of multiple tokens separated by
       ``sep`` character, remove ``token`` from the list.  Example::
  
        remove_token('a:b:c:b:d', 'b', ':')

   * -
     -


*********************
 Directory Hierarchy
*********************

- ``utils``: Contains utilities useful to manage this project.


*************
 Future Work
*************



############
Git Dotfiles
############

TODO
- Painless mereg

*********************
Configure Git Dotfile
*********************

- Update user details as required.


***********
Git Aliases
***********

.. list-table:: Git Aliases
   :widths: auto
   :header-rows: 1

   * - Alias
     - Mnemonic
     - Description

   * - ec
     - Edit Config
     - Edit git's Configs

   * - cl
     - Clone
     - Create clone from local repo.

   * - ok
     -
     - Check state of repo before a push.

   * - co
     - CheckOut
     -

   * - ls, ll
     -
     - Display compact log.

   * - d
     - Diff
     -

   * - dc
     - Diff Cached
     -

   * - br
     - Branch with Paging
     - If no args. to ``br``, then use pager (if required) to list all
       branches; else use args.

   * - b
     -
     -

   * - fo
     - Fetch Origin
     -

   * - po
     - Push Origin
     - Push current branch to origin

   * - s
     - Status
     - (Deprecated: Use vim-fugitive Gstatus instead?)  Condensed status.

   * - rev
     - Review
     - (Deprecated: Not required anymore?)  Create diff for merged code review.

   * -
     -
     -

*************
Painlessmerge
*************

Source: `Painless Merge Conflict Resolution in Git
<http://blog.wuwon.id.au/2010/09/painless-merge-conflict-resolution-in.html>`__

The vim buffer names indicate which commit the file came from-

- BASE: From state "A"
- REMOTE: From state "B"
- LOCAL: From state "C"
- <conflicting-filename>: From state "D"

