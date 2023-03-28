
#################
``tmux`` Dotfiles
#################

``tmux`` Dotfiles are provided by the :file:`./tmux-config` sub-repository.

This repository is taken from `Sarkutz/tmux-config
<https://github.com/Sarkutz/tmux-config>`__, which is a fork of
`samoshkin/tmux-config <https://github.com/samoshkin/tmux-config>`__.
Install it as per instructions :file:`./tmux-config/readme.md`.

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

