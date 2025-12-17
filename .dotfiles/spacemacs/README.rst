
##################
Spacemacs Dotfiles
##################

.. contents:: Contents
   :depth: 1

************
Introduction
************

Spacemacs is an Emacs distribution that provides a Vim-like interface to Emacs.
I use it mainly for org-mode.


************
Dependencies
************

.. list-table:: (Neo)Vim Dependencies
   :widths: auto
   :header-rows: 1

   * - Dependency
     - Used by
     - Installation Source
     - Notes

   * - Emacs
     - .
     - Systems’s package manager.
     - On Ubuntu::

          sudo apt install emacs-gtk

   * - .
     - .
     - .
     - .


************
Installation
************

Install Spacemacs from https://www.spacemacs.org/. Usually, we only need
to close the spacemacs repo to :file:`~/.emacs/`.

::

   cp -rf $DOTFILES/../spacemacs/private ~/.emacs/


**************
Setup Overview
**************

