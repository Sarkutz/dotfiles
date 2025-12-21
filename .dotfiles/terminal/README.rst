
#################
Terminal Dotfiles
#################

.. contents:: Contents
   :depth: 2

############
Introduction
############

I use `WezTerm <https://wezterm.org/>`__ as my terminal. This section
provides configurations for WezTerm.


############
Dependencies
############

.. list-table:: Dependencies
   :header-rows: 1

   * - Dependency
     - Used by
     - Installation Source
     - Notes

   * - WezTerm
     - .
     - `WezTerm <https://wezterm.org/>`__
     - .

   * - Nerd Font for JetBrains Mono
     - .
     - `gh:ryanoasis/nerd-fonts <https://github.com/ryanoasis/nerd-fonts#option-1-release-archive-download>`__
     - Installation instruction::

          cd /tmp/
          curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
          tar -xf JetBrainsMono.tar.xz
          mv JetBrainsMono*/.ttf ~/.local/share/fonts/



############
Installation
############

#. Install `dependencies`_.

#. The dotfiles are automatically installed in :file:`~/.config`.


##############
Setup Overview
##############

Usage
=====

#. Start wezterm as an application.

#. Start from a terminal::

      wezterm

#. Start with default fonts and colors (required for org-mode in Spacemacs)::

      WEZTERM_ENV=emacs wezterm start --always-new-process


Dotfiles Provided
=================

Config files are checked-in in :file:`~/.config/wezterm/`-

- :file:`wezterm.lua`
- :file:`base_config.lua`


Shortcuts Provided
==================

.. list-table:: Shortcuts Provided
   :header-rows: 1

   * - Shortcut
     - Definition in
     - Description

   * - :kbd:`<C-A-w>`
     - :file:`base_config.lua`
     - Leader Key

   * - :kbd:`LEADER l`
     - :file:`base_config.lua`
     - Show WezTerm launcher.

   * - :kbd:`C-A-MOUSE1`
     - :file:`base_config.lua`
     - Open hyperlink under cursor in web browser.

   * - .
     - .
     - .

