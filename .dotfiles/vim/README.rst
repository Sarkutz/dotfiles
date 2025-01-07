
#################
(Neo)Vim Dotfiles
#################

.. contents:: Contents

.. attention::

   Plugin: coc.vim: Stay on :code:`48279de173f6b4accd3aba07cffeb297b7f40f65`.
   If error like "-complete used without -nargs" then change :code:`-nargs=0`
   to :code:`-nargs=?` on error line.


************
Installation
************

Only the `Dependencies`_ need to be installed.  Dotfiles are installed during
checkout.  After installing the dependencies invoke :code:`:checkhealth`
inside NeoVim and follow the recommendation to complete the setup, as
required.

Please see the `Dependencies`_ section below.


**************
Setup Overview
**************

Files-

- :file:`.vimrc` (which sources files in :file:`.dotfiles/vim/`)

- :file:`.config/nvim/init.vim`: contains NeoVim specific
  configurations.  Sources :file:`.vimrc` for configurations common to Vim and
  NeoVim.

- :file:`.config/nvim/coc-settings.json`: contains coc.nvim's (plugin)
  configurations.

- Files in :file:`.vim/` (including plugins as subrepositories in
  :file:`.vim/bundle/`).


We might get the following errors on macOS's default vim::

   LeaderF requires Vim compiled with python and/or a compatible python version.
   UltiSnips requires py >= 2.7 or py3


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

   * - Setup Locale
     - .
     - .
     - If we get the following error::

          ValueError: unknown locale: UTF-8

       Ensure that the following are enabled in BASH dotfiles::

          export LC_ALL=en_US.UTF-8
          export LANG=en_US.UTF-8
          # export LC_CTYPE=en_US.UTF-8  # if required

   * - ``rg``
     - ``<leader>jrg`` LeaderF command in ``plugins.vim``.
     - `BurntSushi/ripgrep <https://github.com/BurntSushi/ripgrep>`__
     - .

Dependencies: Language Server
-----------------------------

If we get the following error::

   [coc.nvim] build/index.js not found, please install dependencies and compile coc.nvim by: yarn install

then run::

   cd ~/.vim/bundle/coc.nvim
   yarn install
   yarn build


The dependencies listed below are required by the coc.nvim Language Server
Protocol (LSP) client.  They can be installed after (Neo)Vim is setup.

.. list-table:: (Neo)Vim Language Server Dependencies
   :widths: auto
   :header-rows: 1

   * - Dependency
     - Installation Source
     - Notes

   * - `bash-language-server
       <https://github.com/bash-lsp/bash-language-server>`__
     - See `bash-lsp/bash-language-server
       <https://github.com/bash-lsp/bash-language-server>`__
     - bash-language-server must be available on the PATH.

   * - `coc-ultisnips <https://github.com/neoclide/coc-sources>`__
     - :code:`:CocInstall coc-ultisnips`
     - Include Ultisnip snippets in auto-complete.  It is a part of
       `coc-sources <https://github.com/neoclide/coc-sources>`__

   * - `coc-json <https://github.com/neoclide/coc-json>`__
     - :code:`:CocInstall coc-json`
     - LSP wrapper for coc.nvim's :file:`coc-settings.json` file.  Essentially,
       it is JSON with comments.

   * - `coc-jedi <https://github.com/pappasam/coc-jedi>`__
     - :code:`:CocInstall coc-jedi`
     - LSP wrapper for jedi-language-server for Python.

   * - `coc-esbonio <https://github.com/yaegassy/coc-esbonio>`__
     - :code:`:CocInstall coc-esbonio`
     - ReStructuredText language server.  

       The required configurations are present in :file:`coc-settings.json`
       (part of this repo).

   * - `ccls <https://github.com/MaskRay/ccls>`__
     - System's package manager.  Also install `Bear
       <https://github.com/rizsotto/Bear>`__ (to generate compilation database
       for clang) using system's package manager.
     - The required configurations are present in :file:`coc-settings.json`
       (part of this repo).

   * - `coc-diagnostic <https://github.com/iamcco/coc-diagnostic>`__
     - :code:`:CocInstall coc-diagnostic`
     - coc-diagnostic provides linters and formatters for many languages.

       The required configurations are present in :file:`coc-settings.json`
       (part of this repo).

   * - `coc-ltex
       <https://valentjn.github.io/ltex/vscode-ltex/installation-usage-coc-ltex.html>`__
     - :code:`:CocInstall coc-ltex`
     - coc-ltex natural language (like English) checks (like spelling, grammar
       and style checks).  

       The required configurations are present in :file:`coc-settings.json`
       (part of this repo).

   * - coc-metals
     - :code:`:CocInstall coc-metals`
     - Deprecated?

Dependencies: Plugins
---------------------

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

   * - vim-pathogen
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

   * - coc.nvim
     - Dev.
     - Language server client for (Neo)vim.  Installation: Clone
       `neoclide/coc.nvim/ <https://github.com/neoclide/coc.nvim/>`__.

   * - Gundo.vim
     - Dev.
     - Plugin to visualise and work with Gundo.vim  Installation: Clone
       `sjl/gundo.vim <https://github.com/sjl/gundo.vim>`__.

   * - vim-signature
     - View
     - Display and navigate marks.  Installation: Clone `kshenoy/vim-signature
       <https://github.com/kshenoy/vim-signature>`__.


Shortcuts Provided
==================

The ``mapleader`` is set to `` `` (``<space>``) in ``base.vim``.

Note: ``<tab>`` is used for UltiSnip snippet completion; ``<C-space>`` is used
to manually trigger coc.nvim's auto-complete.

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

   * - ``<leader>cq``
     - ``base.vim``
     - Shortcuts
     - Close location lists

   * - ``<C-c>``
     - ``base.vim``
     - Shortcuts
     - Copy visually selected text to system's clipboard.

   * - ``<leader>d``
     - ``base.vim``
     - Shortcuts
     - Print PWD (``:pwd``)

   * - ``:call Recover``
     - ``base.vim``
     - Shortcuts
     - TODO: Used to recover when swap file is present.

   * - ``<leader>djpp``
     - ``base.vim``
     - Shortcuts
     - Pretty print visually selected JSON (using ``jq``).

   * - ``prefix<tab>``
     - UltiSnips default
     - Shortcuts
     - UltiSnips: Trigger completion of snippet that starts with ``prefix``.

   * - ``prefix<S-tab>``
     - ``plugins.vim``
     - Shortcuts
     - UltiSnips: List all applicable snippets that start with ``prefix``.

   * - ``<leader>ff``
     - ``plugins.vim``
     - Shortcuts
     - LeaderF: Fuzzy search for files under current directory hierarchy.

   * - ``<leader>bb``
     - ``plugins.vim``
     - Shortcuts
     - LeaderF: Fuzzy search for open buffers.

   * - ``<leader>jt``
     - ``plugins.vim``
     - Shortcuts
     - LeaderF: Fuzzy search for tag.

   * - ``<leader>ji``
     - ``plugins.vim``
     - Shortcuts
     - LeaderF: Fuzzy search for line in current buffer.

   * - ``<leader>hlc``
     - ``plugins.vim``
     - Shortcuts
     - LeaderF: Fuzzy search LeaderF's commands.

   * - ``<leader>jrg``
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

   * - ``<leader>u``
     - ``plugins.vim``
     - Shortcuts
     - Gundo.vim: Open Gundo's windows: one containing the undo tree, the
       other to preview the diff of the selected undo.

   * - ``<c-space>``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: Trigger completion using the language server.

   * - ``if``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: text object for inside function around cursor.

   * - ``af``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: text object for around function around cursor.

   * - ``ic``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: text object for inside class around cursor.

   * - ``ac``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: text object for around class around cursor.

   * - ``[g``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: Jump to line containing the previous diagnostic message
       provided by the language server.

   * - ``]g``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: Jump to line containing the next diagnostic message provided
       by the language server.

   * - ``gd``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: Goto definition of symbol under the cursor using the language
       server.

   * - ``gy``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: Goto definition of the type of the symbol under the cursor
       using the language server.

   * - ``gi``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: Goto implementation of the function name under the cursor
       using the language server.

   * - ``gr``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: Show references of the symbol under the cursor using the
       language server.

   * - ``K``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: Show documentation of the word under the cursor (in a preview
       window) using the language server.

   * - ``rn``
     - ``coc.vim``
     - Editing
     - coc.nvim: Rename symbol under the cursor using the language server.

   * - ``cvf``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: Format selected code using the language server.

   * - ``<leader>ld``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: "List Diagnostics": Run diagnositics using the language
       server.

   * - ``<leader>jo``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: "Jump Outline": List outline of symbols in current file using
       the language server.

   * - ``<leader>O``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: "Outline": Toggle outline of symbols in current file in
       sidebar using the language server.

   * - ``<leader>js``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: "Jump Symbols": List symbols in the current workspace using
       the language server.

   * - ``<leader>lr``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: "List Resume": Resume latest coc list.

   * - ``<leader>he``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: "Help Extensions": List coc.nvim's extensions.

   * - ``<leader>hcc``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: "Help Common Commands": List language servers's commands.

   * - ``<leader>hl``
     - ``coc.vim``
     - Shortcuts
     - coc.nvim: "Help List": Run ``:CocList``.

.. list-table:: Shortcuts Provided (reST)
   :widths: auto
   :header-rows: 1

   * - Shortcut
     - Definition in
     - Class
     - Description

   * -
     -
     -
     -

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

   * - ``<leader>t``
     - ``coc.vim``
     - Dev.
     - coc.vim: goto corresponding test file.

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
- coc.vim

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

``coc.vim``
-----------

Contains configurations for coc.nvim plugin (language server client).

Sourced from ``plugin.vim``.


***********
Future Work
***********

- Try `coc-metals <https://github.com/ckipp01/coc-metals>`__ language server
  client.

