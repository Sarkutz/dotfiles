
#################
(Neo)Vim Dotfiles
#################

.. contents:: Contents

************
Installation
************

Only the `Dependencies`_ need to be installed.  Dotfiles are installed during
checkout.

Please see the `Dependencies`_ section below.


**************
Setup Overview
**************

Files-

- :file:`.vimrc` (which sources files in :file:`.dotfiles/vim/`)
- Files in :file:`.vim/` (including plugins as subrepositories in
  :file:`.vim/bundle/`).

NeoVim: :file:`$HOME/.config/nvim/init.vim` from this repo.


Classification
==============

The configurations are divided into the following classes/sections:

- View: Related to visual appearence.
- Editing: Related to manipulating text.
- Behaviour: Configuring vim's behaviour.
- Shortcuts: Misc shortcuts/keybindings
- NeoVim: Specific to NeoVim


(Neo)Vim Plugins classes-

- Plugin Manager
- Visuals
- Navigator
- Dev (ft).
- Misc


Dependencies
============

.. list-table:: (Neo)Vim Dependencies
   :widths: auto
   :header-rows: 1

   * - Dependency
     - Used by
     - Installation Source
     - Notes

   * - ``rst2confluence.py``
     - ``:ToConflu`` command in ``ft.vim`` (which uses
       ``utils/rst2conflu.sh``)
     - Github: `kenichiro22/rst2confluence
       <https://github.com/kenichiro22/rst2confluence>`__
     - ``pip install`` did not work properly.

   * - ``rg``
     - ``<leader>rg`` LeaderF command in ``plugins.vim``.
     - `BurntSushi/ripgrep <https://github.com/BurntSushi/ripgrep>`__
     -

Plugin Dependencies
-------------------

Please find the details of the (Neo)Vim plugins provided by this repository in
this section.

The plugin dependencies are provided as submodules.  Hence, we need to fetch
the plugin subrepositories, using the following commands, to install them::

   kdfgit submodule init
   kdfgit submodule update --recursive


.. list-table:: (Neo)Vim Plugins
   :widths: auto
   :header-rows: 1

   * - Plugin
     - Class
     - Description

   * - ``vim-pathogen``
     - Plugin Manager
     - The original Plugin Manager.  Installation (as per `tpope/vim-pathogen
       <https://github.com/tpope/vim-pathogen>`__)::

         curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

   * - gruvbox
     - Visuals
     - Light color scheme that is easy on the eyes.  Installation::

         curl -LSso $HOME/.vim/color/gruvbox.vim https://raw.githubusercontent.com/morhetz/gruvbox/master/colors/gruvbox.vim

   * - zenburn
     - Visuals
     - (Deprecated.)  Good dark color scheme.  Currently deactivated as it
       only has a dark color scheme.  Installation::

         curl -LSso $HOME/.vim/color/zenburn.vim https://raw.githubusercontent.com/jnurmine/Zenburn/master/colors/zenburn.vim

   * - lightline.vim
     - Visuals
     - Configurable, informative status line.  Installation: Clone
       `itchyny/lightline <https://github.com/itchyny/lightline.vim>`__.
       Also clone 
       `morhetz/gruvbox <https://github.com/morhetz/gruvbox.git>`__ for
       colors.

   * - LeaderF
     - Navigator
     - Fuzzy Finder to find files, buffers, tags, previous commands, etc.
       Installation: Clone `Yggdroot/LeaderF
       <https://github.com/Yggdroot/LeaderF.git>`__.

   * - vim-surround
     - Misc.
     - Enclosing text in paranthesis (or in any other character/tag).
       Installation: Clone `tpope/vim-surround
       <https://github.com/tpope/vim-surround.git>`__.

   * - vim-unimpaired
     - Misc.
     - Installation: Clone `tpope/vim-unimpaired
       <https://github.com/tpope/vim-unimpaired.git>`__.

   * - cscope_maps
     - Dev.
     - Cscope bindings.  Installation::

         curl -LSso $HOME/.vim/bundle/cscope_maps/plugin/cscope_maps.vim http://cscope.sourceforge.net/cscope_maps.vim

   * - SimplyFold
     - Dev. (Python)
     - Folding for Python.  Installation: Clone `tmhedberg/SimpylFold
       <https://github.com/tmhedberg/SimpylFold.git>`__.

   * - csv.vim
     - Dev., ML
     - Processing CSV files.  Installation: Clone `chrisbra/csv.vim
       <https://github.com/chrisbra/csv.vim.git>`__.

   * - Nvim-R
     - Dev. (R), ML
     - IDE for R.  Installation: Clone `jalvesaq/Nvim-R
       <https://github.com/jalvesaq/Nvim-R.git>`__.

   * - vim-go
     - Dev. (Go)
     - IDE for Go.  Installation: Clone `fatih/vim-go
       <https://github.com/fatih/vim-go.git>`__. ::

          :GoInstallBinaries

   * - UltiSnips
     - Dev.
     - Snippet engine.  Installation: Clone `SirVer/ultisnips
       <https://github.com/SirVer/ultisnips.git>`__.  Also install
       vim-snippets.

   * - vim-snippets
     - Dev.
     - Recepie of snippets (required for UltiSnips).  Installation: Clone:
       `honza/vim-snippets <https://github.com/honza/vim-snippets.git>`__.

   * - vim-slime
     - Dev.
     - Send command from vim.  I use it to send command from NeoVim to
       NeoVim's embedded terminal.  Installation: Clone `jpalardy/vim-slime
       <https://github.com/jpalardy/vim-slime.git>`__.

   * - screen
     - Dev.
     - Open a shell in vim and send command to it.  For NeoVim, see vim-slime.
       Installation: Clone `ervandew/screen
       <https://github.com/ervandew/screen>`__.

   * - vim-fugitive
     - Dev.
     - Git commands from vim.  Installation: Clone `tpope/vim-fugitive
       <https://github.com/tpope/vim-fugitive.git>`__.


Shortcuts Provided
==================

The ``mapleader`` is set to `` `` (``<space>``) in ``base.vim``.

.. list-table:: Shortcuts Provided (Common)
   :widths: auto
   :header-rows: 1

   * - Shortcut
     - Definition in
     - Class
     - Description

   * - ``<F9>``
     - ``base.vim``
     - Editing
     - Toggle paste mode.

   * - ``<C-S>``
     - ``base.vim``
     - Behaviour
     - Save file.

   * - ``<C-L>``
     - ``base.vim``
     - Searching
     - Clear search; redraw screen.

   * - ``<C-Q>``
     - ``base.vim``
     - Shortcuts
     - Close window (:command:`:q`)

   * - ``<leader>tn``
     - ``base.vim``
     - Shortcuts
     - Tab New: Open new (empty) tab.

   * - ``<leader>c``
     - ``base.vim``
     - Shortcuts
     - Close location lists

   * - ``<C-c>``
     - ``base.vim``
     - Shortcuts
     - Copy visually selected text to system's clipboard.

   * - ``:call Recover``
     - ``base.vim``
     - Shortcuts
     - TODO: Used to recover when swap file is present.

   * - ``<leader>djpp``
     - ``base.vim``
     - Shortcuts
     - Pretty print visually selected JSON (using ``jq``).

   * - ``prefix<S-tab>``
     - ``plugins.vim``
     - Shortcuts
     - UltiSnips: List all applicable snippets that start with ``prefix``.

   * - ``<leader>f``
     - ``plugins.vim``
     - Shortcuts
     - LeaderF: Fuzzy search for files under current directory hierarchy.

   * - ``<leader>b``
     - ``plugins.vim``
     - Shortcuts
     - LeaderF: Fuzzy search for open buffers.

   * - ``<leader>l``
     - ``plugins.vim``
     - Shortcuts
     - LeaderF: Fuzzy search LeaderF's commands.

   * - ``<leader>rg``
     - ``plugins.vim``
     - Shortcuts
     - LeaderF: Search using ripgrep and fuzzy search over it's output.

   * - ``<leader>gs``
     - ``plugins.vim``
     - Shortcuts
     - vim-fugitive: Shortcut for :code:`:Gstatus`.

   * - ``<leader>go``
     - ``plugins.vim``
     - Shortcuts
     - vim-fugitive: Shortcut for :code:`:Git ok`.

   * - ``<leader>si``
     - ``plugins.vim``
     - Shortcuts
     - vim-slime: Get the terminal job ID (NeoVim only).

   * - ``<leader>sc``
     - ``plugins.vim``
     - Shortcuts
     - vim-slime: Configure slime to send text from the current buffer to the
       specifed target.

   * - ``<leader>ss``
     - ``plugins.vim``
     - Shortcuts
     - vim-slime: Send the current line or visually selected region to the
       configured target.


.. list-table:: Shortcuts Provided (reST)
   :widths: auto
   :header-rows: 1

   * - Shortcut
     - Definition in
     - Class
     - Description

   * - ``:ToConflu``
     - ``ft.vim``
     - Dev.
     - Compile reST file in current buffer and copy the output to the
       clipboard.


.. list-table:: Shortcuts Provided (Go)
   :widths: auto
   :header-rows: 1

   * - Shortcut
     - Definition in
     - Class
     - Description

   * - ``<leader>gr``
     - ``ft.vim``
     - Dev.
     - vim-go ``:GoRun``

   * - ``<leader>gb``
     - ``ft.vim``
     - Dev.
     - vim-go ``:GoBuild``

   * - ``<leader>gt``
     - ``ft.vim``
     - Dev.
     - vim-go ``:GoTest``

   * - ``<leader>gct``
     - ``ft.vim``
     - Dev.
     - vim-go ``:GoCoverageToggle``

   * - ``<leader>gr``
     - ``ft.vim``
     - Dev.
     - vim-go ``:GoRun``

   * - ``<leader>gl``
     - ``ft.vim``
     - Dev.
     - vim-go ``:GoMetaLinter``


Folder Organisation
===================

(Neo)Vim configurations consist of three parts-

- base.vim
- ft.vim
- plugin.vim

``base.vim``
------------


``ft.vim``
----------

- ConfigText
- ConfigRst
- ConfigC: also C++
- ConfigMake
- ConfigPython
- ConfigSh
- ConfigR
- ConfigMatlab
- ConfigTeX: latex
- ConfigHtml
- ConfigVim
- ConfigGo
- ConfigCrontab

``plugin.vim``
--------------


***********
Future Work
***********

