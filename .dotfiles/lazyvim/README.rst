
################
LazyVim Dotfiles
################

.. contents:: Contents
   :depth: 2

************
Introduction
************

I use LazyVim as my NeoVim distribution. This page mentions my customisations
to LazyVim.


************
Dependencies
************

.. list-table:: Dependencies
   :widths: auto
   :header-rows: 1
   :stub-columns: 1

   * - Dependency
     - Used by
     - Installation Source
     - Notes

   * - LazyVim
     - Core
     - Don't install
     - No need to install as it's provided by this repo at ``~/.config/nvim/``.

   * - Lua
     - LazyVim
     - System package manager
     - Installation on Ubuntu::

          sudo apt install lua5.4

   * - ``tree-sitter-cli``
     - LazyVim
     - NPM
     - Ubuntu::

          sudo npm install -g tree-sitter-cli

   * - ``mermaid-cli``
     - LazyVim
     - NPM
     - Ubuntu::

          sudo npm install -g @mermaid-js/mermaid-cli


************
Installation
************

Dotfiles already installed to ``~/.config/nvim/``.


**************
Setup Overview
**************

- All configs in ``~/.config/nvim/lua/`` as per LazyVim's conventions.
- Extras (extra LazyVim packages installed by this repo) are listed in
  ``~/.config/nvim/lazyvim.json`` as per LazyVim's conventions.
- Theme/colorscheme: Gruvbox. In ``~/.config/nvim/lua/plugins/gruvbox.lua``.
- Dictionaries: stored in ``~/.config/nvim/dictionary/``


Custom Snippets Provided
========================

Stored in ``~/.config/nvim/snippets/`` using the VSCode snippet syntax.

``rst``
-------

TODO


Formatting Provided
===================

In ``~/.config/nvim/lua/config/autocmds.lua``.

TODO


Shortcuts Provided
==================

.. list-table:: Shortcuts Provided (Common)
   :widths: auto
   :header-rows: 1

   * - Shortcut
     - Definition in
     - Description

   * - ``C-c``
     - ``lua/config/keymaps.lua``
     - (visual mode) Copy visually selected text to the system clipboard.

       Having a separate shortcut allows disabling clipboard support so that
       vim edits do not clobber the system clipboard. We can still use this
       keybinding to intensionally copy to the system clipboard.

   * - <surround>
     - ``lua/plugins/mini-surround.lua``
     - Configure keybindings that match vim-surround.

   * - ``<leader>ue``
     - ``lua/plugins/vim-slime.lua``
     - Slime Config. Configure slime for sending text to tmux pane.

   * - ``<C-i>``
     - ``lua/plugins/vim-slime.lua``
     - Slime Send: Send text to configured tmux pane.

   * - ``C-q``
     - ``lua/plugins/snacks-nvim.lua``
     - (in picker window) Send all listed or selected entries to quickfix.

