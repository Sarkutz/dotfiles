
#################
``tmux`` Dotfiles
#################

.. contents:: Contents
   :depth: 2
   :local:

************
Introduction
************

``tmux`` Dotfiles are provided by the :file:`./tmux-config` sub-repository.

This repository is taken from `Sarkutz/tmux-config
<https://github.com/Sarkutz/tmux-config>`__, which is a fork of
`samoshkin/tmux-config <https://github.com/samoshkin/tmux-config>`__.


************
Dependencies
************

.. list-table:: Common Utilities
   :widths: auto
   :header-rows: 1

   * - Utility
     - Installation Source
     - Notes

   * - Powerline Pached Fonts
     - `powerline/fonts <https://github.com/powerline/fonts>`__
     - tmux-config uses Powerline arrow glyphs.  Hence, we need to install
       "Powerline Pached Fonts".

       Installation::

          git clone https://github.com/powerline/fonts &&
              cd fonts && ./install.sh

       Once installed, update the Terminal font setting to use any "Powerline"
       font (say "Roberto Mono for Powerline").  Then check whether
       ``separator_powerline_left`` is displaying properly in ``~/.tmux.conf``.

   * - ``tmuxp``
     - pip install tmuxp in system Python venv.
     - Created aliases tmuxpl (load) and tmuxpf (fetch) to use tmuxp binary
       fom the systemp Python venv.

   * - ``abicky/swap-pane``
     - `abicky/swap-pane <https://github.com/abicky/swap-pane>`__
     - Install dependency: :command:`peco`.

       Clone and move binary to $PATH::

          git clone https://github.com/abicky/swap-pane
          # mv swap-pane/swap-pane binary to path

       Update :file:`swap-pane` binary to show :code:`#{window_name}` by adding it as
       shown below::
       
          - panes=$(tmux list-panes -sF '#I.#P #{pane_title}' | egrep -v "^($current_pane|$swapped_pane)")
          + panes=$(tmux list-panes -sF '#I.#P #{window_name} #{pane_title}' | egrep -v "^($current_pane|$swapped_pane)")

        Set ``#{pane_title}`` using :code:`set_window_title "Window Title"`
        BASH function (provided by BASH dotfile in this repo).


************
Installation
************

Install dependencies.

Install tmux config files (and plugins) as per instructions
:file:`./tmux-config/readme.md`.


**************
Setup Overview
**************

Keybindings Provided
====================

.. list-table:: Keybindings Provided (after tmux prefix key)
   :widths: auto
   :header-rows: 1

   * - Keybinding
     - Description

   * - ``a``
     - Swap current pane with existing pane.  An interactive window is opened
       to select the existing pane.

   * - ``A``
     - Create new pane and swap current pane with it.

   * - ``C-l``
     - Load latest saved tmux sessions (using tmux-resurrect).


Plugins Installed
=================

.. list-table:: Plugins Installed
   :widths: auto
   :header-rows: 1

   * - Keybinding
     - Description

   * - tmux-resurrect
     - Load and save all sessions.

       - ``C-s``: save all sessions.
       - ``C-l`` (configured by dotfiles): Load latest saved sessions.

       Sessions are saved in :file:`~/.tmux/resurrect/`.

