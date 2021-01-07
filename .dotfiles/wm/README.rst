
##############
Window Manager
##############

*Setup for tiling window managers*.

.. contents:: Contents
   :depth: 1
   :local:

******
Mac OS
******

Dependencies
============

.. list-table::
   :widths: auto
   :header-rows: 1

   * - Dependency
     - Installation Source
     - Notes

   * - `skhd <https://github.com/koekeishiya/skhd>`__
     - System's package manager::

          brew install koekeishiya/formulae/skhd

     - Simple Hotkey Daemon. ::

          brew services start skhd
          # Grant permission to use Accessability API, then restart

   * - `yabai <https://github.com/koekeishiya/yabai>`__
     - System's package manager (`source
       <https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)>`__-

       - Disable System Integrity Protection (SIP).
       - Configure Mission Control as per https://github.com/koekeishiya/yabai
       - :code:`brew install koekeishiya/formulae/yabai`.
       - :code:`rew services start yabai`.  Grant permission to use
         Accessability API.
       - :code:`sudo yabai --install-sa`

     - Tiling window manager


Dotfiles Overview
=================

Files provided-

- :file:`~/.config/skhd/skhdrc`
- :file:`~/.config/yabai/yabairc`


.. list-table:: Key Binding / Hotkeys
   :widths: auto
   :header-rows: 1

   * - Hotkey
     - Description

   * - :kbd:`<C-cmd-enter>`
     - (Space) Move focus to next space.

   * - :kbd:`<C-cmd-shift-enter>`
     - (Space) Move focus to previous space.

   * - :kbd:`<C-cmd-n>`
     - (Space) Switch layout to "float".

   * - :kbd:`<C-cmd-m>`
     - (Space) Switch layout to "bsp" (binary space partitioning).

   * - :kbd:`<C-cmd-x>`
     - (Space) Mirror/swap window across horizontal/X-axis.

   * - :kbd:`<C-cmd-y>`
     - (Space) Mirror/swap window across horizontal/X-axis.

   * - :kbd:`<C-cmd-r>`
     - (Space) Rotate windows 90 degrees anti-clockwise.

   * - :kbd:`<C-cmd-shift-r>`
     - (Window) Toggle split type (horizontal/vertical).

   * - :kbd:`<C-cmd-h>`
     - (Window) Move focus to window to the left.

   * - :kbd:`<C-cmd-j>`
     - (Window) Move focus to window to the bottom.

   * - :kbd:`<C-cmd-k>`
     - (Window) Move focus to window to the top.

   * - :kbd:`<C-cmd-l>`
     - (Window) Move focus to window to the right.

   * - :kbd:`<C-cmd-shift-h>`
     - (Window) Reduce size from left edge by 50.

   * - :kbd:`<C-cmd-shift-j>`
     - (Window) Increase size from bottom edge by 50.

   * - :kbd:`<C-cmd-shift-k>`
     - (Window) Reduce size from top edge by 50.

   * - :kbd:`<C-cmd-shift-l>`
     - (Window) Increase size from right edge by 50.

   * - :kbd:`<C-cmd-a>`
     - (Window) Swap position with window to the left.

   * - :kbd:`<C-cmd-s>`
     - (Window) Swap position with window to the bottom.

   * - :kbd:`<C-cmd-w>`
     - (Window) Swap position with window to the top.

   * - :kbd:`<C-cmd-d>`
     - (Window) Swap position with window to the right.

   * - :kbd:`<C-cmd-shift-a>`
     - (Window) Warp window to the left by making active window it's sibling.

   * - :kbd:`<C-cmd-shift-s>`
     - (Window) Warp window to the bottom by making active window it's sibling.

   * - :kbd:`<C-cmd-shift-w>`
     - (Window) Warp window to the top by making active window it's sibling.

   * - :kbd:`<C-cmd-shift-d>`
     - (Window) Warp window to the right by making active window it's sibling.

   * - :kbd:`<C-cmd-o>`
     - (Window) Zoom fullscreen.

   * - :kbd:`<C-cmd-i>`
     - (Window) Zoom parent.

   * - :kbd:`<C-cmd-1>`
     - (Window) Move active window to space 1.  (Stay on current space.)

   * - :kbd:`<C-cmd-2>`
     - (Window) Move active window to space 2.  (Stay on current space.)

   * - :kbd:`<C-cmd-3>`
     - (Window) Move active window to space 3.  (Stay on current space.)

   * - :kbd:`<C-cmd-4>`
     - (Window) Move active window to space 4.  (Stay on current space.)

   * - :kbd:`<C-cmd-5>`
     - (Window) Move active window to space 5.  (Stay on current space.)

   * - :kbd:`<C-cmd-6>`
     - (Window) Move active window to space 6.  (Stay on current space.)

   * - :kbd:`<C-cmd-p>`
     - (Window) Toggle picture-in-picture mode.  This makes the window float
       which needs to be undone separately.

   * - :kbd:`<C-cmd-f>`
     - (Window) Toggle float.


*****
Linux
*****

TODO: i3?

