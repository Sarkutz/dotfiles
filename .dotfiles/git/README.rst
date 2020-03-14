
############
Git Dotfiles
############

Files-

- :file:`~/.gitconfig`


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


***********
Future Work
***********

- Update doc for `Painlessmerge`_.

