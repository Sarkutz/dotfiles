;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(javascript
     html
     python
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     (auto-completion :variables
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-idle-delay nil
                      ac-auto-start 6)
     ;; better-defaults
     emacs-lisp
     git
     helm
     ;; lsp
     ;; markdown
     multiple-cursors
     org
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     spell-checking
     syntax-checking
     ;; version-control
     treemacs
     (xclipboard :variables
                 xclipboard-copy-command "wl-copy"  ;; For Wayland
                 xclipboard-paste-command "wl-paste --no-newline"  ;; For Wayland
                 xclipboard-enable-cliphist t)
     (org :variables
          org-projectile-file "docs/todos.org"
          org-enable-roam-support t
          org-enable-roam-ui t
          )
     )

   ;; List of additional packages that will be installed without being wrapped
   ;; in a layer (generally the packages are installed only and should still be
   ;; loaded using load/require/use-package in the user-config section below in
   ;; this file). If you need some configuration for these packages, then
   ;; consider creating a layer. You can also put the configuration in
   ;; `dotspacemacs/user-config'. To use a local version of a package, use the
   ;; `:location' property: '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(gruvbox-theme leuven-theme)

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Name of executable file pointing to emacs 27+. This executable must be
   ;; in your PATH.
   ;; (default "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=$HOME/.emacs.d/.cache/dumps/spacemacs-27.1.pdmp
   ;; (default (format "spacemacs-%s.pdmp" emacs-version))
   dotspacemacs-emacs-dumper-dump-file (format "spacemacs-%s.pdmp" emacs-version)

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; Set `read-process-output-max' when startup finishes.
   ;; This defines how much data is read from a foreign process.
   ;; Setting this >= 1 MB should increase performance for lsp servers
   ;; in emacs 27.
   ;; (default (* 1024 1024))
   dotspacemacs-read-process-output-max (* 1024 1024)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. Spacelpa is currently in
   ;; experimental state please use only for testing purposes.
   ;; (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version t

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `recents-by-project' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   ;; The exceptional case is `recents-by-project', where list-type must be a
   ;; pair of numbers, e.g. `(recents-by-project . (7 .  5))', where the first
   ;; number is the project limit and the second the limit on the recent files
   ;; within a project.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Show numbers before the startup list lines. (default t)
   dotspacemacs-show-startup-list-numbers t

   ;; The minimum delay in seconds between number key presses. (default 0.4)
   dotspacemacs-startup-buffer-multi-digit-delay 0.4

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; If non-nil, *scratch* buffer will be persistent. Things you write down in
   ;; *scratch* buffer will be saved and restored automatically.
   dotspacemacs-scratch-buffer-persistent nil

   ;; If non-nil, `kill-buffer' on *scratch* buffer
   ;; will bury it instead of killing.
   dotspacemacs-scratch-buffer-unkillable nil

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(
                         ;; spacemacs-light
                         ;; spacemacs-dark
                         leuven
                         leuven-dark
                         gruvbox-light-medium
                         gruvbox-dark-medium
                         )

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font or prioritized list of fonts. The `:size' can be specified as
   ;; a non-negative integer (pixel size), or a floating-point (point size).
   ;; Point size is recommended, because it's device independent. (default 10.0)
   dotspacemacs-default-font '("Source Code Pro"
                               :size 16.0
                               :weight normal
                               :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m" for terminal mode, "<M-return>" for GUI mode).
   ;; Thus M-RET should work as leader key in both GUI and terminal modes.
   ;; C-M-m also should work in terminal mode, but not in GUI mode.
   dotspacemacs-major-mode-emacs-leader-key (if window-system "<M-return>" "C-M-m")

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' in OSX to obtain
   ;; borderless fullscreen. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Show the scroll bar while scrolling. The auto hide time can be configured
   ;; by setting this variable to a number. (default t)
   dotspacemacs-scroll-bar-while-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but only visual lines are counted. For example, folded lines will not be
   ;; counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers 'visual

   ;; Code folding method. Possible values are `evil', `origami' and `vimish'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil and `dotspacemacs-activate-smartparens-mode' is also non-nil,
   ;; `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil smartparens-mode will be enabled in programming modes.
   ;; (default t)
   dotspacemacs-activate-smartparens-mode t

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server t

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server t

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   ;; dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; If nil then Spacemacs uses default `frame-title-format' to avoid
   ;; performance issues, instead of calculating the frame title by
   ;; `spacemacs/title-prepare' all the time.
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Show trailing whitespace (default t)
   dotspacemacs-show-trailing-whitespace t

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; If non-nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfere with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode t

   ;; Accept SPC as y for prompts if non-nil. (default nil)
   dotspacemacs-use-SPC-as-y nil

   ;; If non-nil shift your number row to match the entered keyboard layout
   ;; (only in insert state). Currently supported keyboard layouts are:
   ;; `qwerty-us', `qwertz-de' and `querty-ca-fr'.
   ;; New layouts can be added in `spacemacs-editing' layer.
   ;; (default nil)
   dotspacemacs-swap-number-row nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil

   ;; If nil the home buffer shows the full path of agenda items
   ;; and todos. If non-nil only the file name is shown.
   dotspacemacs-home-shorten-agenda-source nil

   ;; If non-nil then byte-compile some of Spacemacs files.
   dotspacemacs-byte-compile nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env)
  )

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  )


(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )


(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."

  (spacemacs/declare-prefix "o" "own-menu")

  ;; (ac-set-trigger-key "M-TAB")

  (define-key evil-insert-state-map (kbd "C-SPC") #'company-complete)
  (define-key evil-insert-state-map (kbd "C-y") #'company-complete-selection)
  (define-key evil-insert-state-map (kbd "C-e") #'company-abort)

  ;; C-s: save file
  (global-set-key (kbd "C-s") #'save-buffer)

  ;; Spellings
  (setq ispell-dictionary "en_GB")

  (golden-ratio-mode)

  ;; De-link kill ring from clipboard, but allow C-v
  ;; (setq select-enable-clipboard nil)
  ;; (define-key evil-insert-state-map (kbd "C-v") #'spacemacs/xclipboard-paste)

  (defun me/clipboard/set (astring)
    "Copy a string to clipboard"
    (with-temp-buffer
      (insert astring)
      (clipboard-kill-region (point-min) (point-max))))

  (defun me/clipboard/get ()
    "Return the content of clipboard as string"
    (interactive)
    (with-temp-buffer
      (clipboard-yank)
      (buffer-substring-no-properties (point-min) (point-max))))

  ;; Org Mode
  ;; ========

  (define-key evil-normal-state-map (kbd "C-j") 'org-insert-item)

  (spacemacs/declare-prefix "oo" "own-org-menu")

  ;; org-directory
  (setq org-directory "~/private/gtd/")

  ;; Make Org Mode create a new item without changing the current lie
  (setq org-M-RET-may-split-line nil)
  ;; Insert new heading after current subtree (instead of below current line)
  (setq org-insert-heading-respect-content t)

  ;; Todo keywords
  ;; If changed, also update org-clock-out-when-done
  (setq org-todo-keywords
        '((sequence
           "REVIEW(r!)"   ;; Unclarified open-loop. Added to log date of addition.
           "PROJ(p)"      ;; Project.  Has 2 or more next actions nested under it.
           "NEXT(n!)"     ;; Next action. Have everything to start working on it.
           "TODO(t!)"     ;; An action whose pre-requisites are not satisfied.
           "APPT(a!)"     ;; Need to be done at specified date.
           "BLOCKED(b@)"  ;; Can't move forward due to reason specified in note.
           "FOLLOWUP(f@)" ;; Follow-up with tagged person at specified date.
           "SOMEDAY(s!)"  ;; Someday maybe dreams.  Backlog
           "|"
           "CANCELLED(c@)";; Decided not to do due to reason specified in note.
           "DONE(d!)"     ;; Completed.
           )))
  (setq org-log-state-notes-into-drawer t)
  (setq org-log-reschedule "time")
  (setq org-log-redeadline "time")

  ;; Tags
  ;; %context
  ;; @user
  ;; #tag (optional)
  ;; Add tags for aTimeLogger tasks: gtd org file study knowl ankify book course idea clarify
  ;; (setq org-tag-alist '
  (setq org-tag-persistent-alist '
        (
         ;; Task management
         ("inbox")  ; First contact, unprocessed
         ("urgent") ; ASAP, try to finish today
         ("next")   ; Work/finish this week
         ;; ("important")  ; Use "%gtd_weekly_review" instead
         ;; Contexts
         ("%errands")
         ("%gtd_weekly_review")
         ("%gtd_daily_review")
         ("%home")
         ("%ipad")
         ("%backlog_grooming")
         ("%sprint_planning")
         ("%standup")
         ("%parliament")
         ;; Time
         ("time_small")
         ("time_mid")
         ;; Energy
         ("energy_low")
         ;; Agendas
         ("@jyoti")
         ;; Type of activity
         ("think")
         ("clarify")
         ("explore")
         ("study")
         ("knowl")
         ("anki")
         ("portfolio")
         ("produce")
         ("comms")
         ("routine")
         ("cleanup")
         ;; followups poc design dev
         ;; Topics
         ("sw_dev")
         ("design_arch")
         ("genai")
         ("mang")
         ("project_mang")
         ("product_mang")
         ))


  ;; Todo/note files
  ;; (setq org-agenda-files "~/private/gtd/agenda-files.txt")
  (setq org-agenda-file-regexp "\\`[^.].*\\.org\\'")
  (setq org-agenda-files (apply 'append
                                (mapcar
                                 (lambda (directory)
                                   (directory-files-recursively directory org-agenda-file-regexp))
                                 '("~/private/gtd/" "~/ashim/" "~/clinic/" "~/family/"))))
  (setq org-agenda-skip-deadline-if-done t)
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-agenda-start-on-weekday nil)


  (setq my-global-date nil)
  (defun +my-get-global-date (prompt) (interactive)
         (setq my-global-date (org-read-date nil nil my-global-date prompt)))
  (defun +my-reset-global-date ()
    (setq my-date my-global-date)
    (setq my-global-date nil)
    my-date)

  (setq org-agenda-custom-commands
        '(("p" "Plan day"
           ((search (org-read-date nil nil "-1d"))
            (tags "CLOSED>\"<-1d>\"/DONE|CANCELLED")
            ;; (search "<today>")
            (tags-todo "inbox")
            (tags-todo "%gtd_daily_review")
            (tags-todo "urgent")
            (agenda ""
                    ((org-agenda-start-day "<today>")
                     (org-agenda-span '1)  ; See schedule and deadline for next 1 day
                     (org-agenda-sorting-strategy '(category-up))))
            (search (org-read-date nil nil "today"))
            (todo "BLOCKED|FOLLOWUP" nil)
            (tags "next" ((org-use-tag-inheritance nil)))))
          ("d" "toDay's agenda"
           ((agenda "" ((org-agenda-span '1)))
            (tags-todo "urgent")
            (tags "%gtd_daily_review")
            (tags "next" ((org-use-tag-inheritance nil)))
            ))
          ("w" "Weekly Review"
           ;; Add everything required to plan the week.
           ((tags "%gtd_weekly_review")))
          ("D" "Day diary"
           ((agenda ""
                    ((org-agenda-span '1)  ; See schedule and deadline for next 1 day
                     (org-agenda-start-day (+my-get-global-date "Diary Date"))  ; prompt for start day
                     ))
            (tags (concat
                   "CLOSED>=\"<" my-global-date
                   ">\"&CLOSED<\"<" (org-read-date nil nil "++1d" nil (org-time-string-to-time my-global-date))
                   ">\"/DONE|CANCELLED"))
            (search (+my-reset-global-date))
            )
           ((org-agenda-archives-mode t))
           )
          ("W" "Week diary"
           ((tags (concat
                   "CLOSED>=\"<" (+my-get-global-date "Week start date") ">\"&CLOSED<\"<"
                   (org-read-date nil nil "++7d" nil (org-time-string-to-time my-global-date))
                   ">\"/DONE|CANCELLED"))
            (agenda ""
                    ((org-agenda-span '7)  ; See schedule and deadline for next 1 day
                     (org-agenda-start-day my-global-date)  ; prompt for start day
                     ))
            (search (+my-get-global-date "Week start date"))
            (search (org-read-date nil nil "++1d" nil (org-time-string-to-time my-global-date)))
            (search (org-read-date nil nil "++2d" nil (org-time-string-to-time my-global-date)))
            (search (org-read-date nil nil "++3d" nil (org-time-string-to-time my-global-date)))
            (search (org-read-date nil nil "++4d" nil (org-time-string-to-time my-global-date)))
            (search (org-read-date nil nil "++5d" nil (org-time-string-to-time my-global-date)))
            (search (org-read-date nil nil "++6d" nil (org-time-string-to-time (+my-reset-global-date))))
            )
           ((org-agenda-archives-mode t))
           )
          ))

  (setq org-refile-targets '(
                             (nil . (:maxlevel . 9))
                             (org-agenda-files . (:tag . "inbox"))
                             ;; ("~/private/diary/source/2021/08/tasks-completed-1.org" . (:maxlevel . 1))
                             ))
  ;; org-refile-use-outline-path does-
  ;; - show full filename in list of refile targets
  ;; - allow refiling to root level of the file
  (setq org-refile-use-outline-path 'full-file-path)
  ;; org-outline-path-complete-in-steps nil works better with helm
  (setq org-outline-path-complete-in-steps nil)
  ;; Explore org-refile-use-cache
  ;; (setq org-refile-use-cache t)

  (setq org-default-notes-file "~/private/gtd/gtd-dash.org")
  (setq org-capture-templates
        '(
          ("c" "Capture" entry
           (file+olp "" "Inbox")
           "** REVIEW %?\n:LOGBOOK:\n- State \"REVIEW\"       from              %U\n:END:")
          ("t" "Today's Task" entry
           (file+olp "" "Today")
           "** REVIEW %?\n:LOGBOOK:\n- State \"REVIEW\"       from              %U\n:END:")
          ("i" "Idea" entry
           (file+olp "gtd-dreams.org" "Ideas")
           "** REVIEW %?\n:LOGBOOK:\n- State \"REVIEW\"       from              %U\n:END:")
          ))

  (defun +org-goto-todos () (interactive) (find-file org-default-notes-file))
  (spacemacs/set-leader-keys "ooo" '+org-goto-todos)
  (defun +org-search () (interactive) (org-refile '(4)))
  (spacemacs/set-leader-keys "oos" '+org-search)

  ;; Org clocking
  (setq org-clock-history-length 20)
  (setq org-agenda-clockreport-parameter-plist '(:wstart 0 :fileskip0 t :compact t :link t :hidefiles t :tags t :timestamp t :properties ("CATEGORY") :formula % :maxlevel 2))
  (setq org-clock-out-remove-zero-time-clocks t)
  (setq org-log-note-clock-out t)
  (setq org-clock-persist t)
  (setq org-clock-out-when-done t)
  (org-clock-persistence-insinuate)

  ;; Customize the HTML output
  (setq org-html-validation-link nil            ;; Don't show validation link
        org-html-head-include-scripts nil       ;; Use our own scripts
        org-html-head-include-default-style nil ;; Use our own styles
        ;; org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />"
        )

  (setq org-publish-project-alist
        '(
          ("org-roam-inherit"
           :base-directory "~/resources/repos/github.com/fniessen/org-html-themes/src/"
           :base-extension "css\\|js"
           :publishing-directory "~/private/knowl/build/html/org-roam/static/"
           :publishing-function org-publish-attachment
           :recursive t
           )
          ("org-roam-content"
           :base-directory "~/private/knowl/source/org-roam/"
           :publishing-directory "~/private/knowl/build/html/org-roam/"
           :base-extension "org"
           :publishing-function org-html-publish-to-html
           :html-head "
<link rel=\"stylesheet\" type=\"text/css\" href=\"/knowl/org-roam/static/bigblow_theme/css/htmlize.css\"/>
<link rel=\"stylesheet\" type=\"text/css\" href=\"/knowl/org-roam/static/bigblow_theme/css/bigblow.css\"/>
<link rel=\"stylesheet\" type=\"text/css\" href=\"/knowl/org-roam/static/bigblow_theme/css/hideshow.css\"/>
<script type=\"text/javascript\" src=\"/knowl/org-roam/static/bigblow_theme/js/jquery-1.11.0.min.js\"></script>
<script type=\"text/javascript\" src=\"/knowl/org-roam/static/bigblow_theme/js/jquery-ui-1.10.2.min.js\"></script>
<script type=\"text/javascript\" src=\"/knowl/org-roam/static/bigblow_theme/js/jquery.localscroll-min.js\"></script>
<script type=\"text/javascript\" src=\"/knowl/org-roam/static/bigblow_theme/js/jquery.scrollTo-1.4.3.1-min.js\"></script>
<script type=\"text/javascript\" src=\"/knowl/org-roam/static/bigblow_theme/js/bigblow.js\"></script>
<script type=\"text/javascript\" src=\"/knowl/org-roam/static/bigblow_theme/js/hideshow.js\"></script>
<script type=\"text/javascript\" src=\"/knowl/org-roam/static/lib/js/jquery.stickytableheaders.min.js\"></script>"
           :recursive t
           :with-author nil
           :with-toc nil
           :section-numbers nil
           :time-stamp-file nil
           :auto-sitemap t                ; Generate sitemap.org automagically...
           :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
           :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.
           )
          ("org-roam-static"
           :base-directory "~/private/knowl/source/org-roam/"
           :publishing-directory "~/private/knowl/build/html/org-roam/"
           :base-extension "css\\|js\\|pdf\\|png\\|jpg\\|gif"
           :publishing-function org-publish-attachment
           :recursive t
           )
          ("org-roam"
           :components ("org-roam-inherit" "org-roam-content" "org-roam-static")
           )

          ("kaizen_org_roam"
           :recursive t
           :base-directory "~/ashim/projbg/kaizen/kaizen-org-roam/"
           :publishing-directory "~/ashim/wiki/build/html/org-roam/"
           :publishing-function org-html-publish-to-html
           :with-toc nil
           :section-numbers nil
           )
          ))
  ;; (setq org-export-backends '(ascii beamer html icalendar))

  (setq org-babel-load-languages '(
                                   (python . t)
                                   (emacs-lisp . t)
                                   (shell . t)
                                   (dot . t)
                                   ))

  (setq org-icalendar-include-todo t)

  ;; org-roam

  ;; (require 'org-roam-export) ; required or not?

  (setq org-roam-directory "~/private/knowl/source/org-roam/")
  (setq org-roam-db-location "~/private/knowl/source/org-roam/org-roam.db")
  (setq org-roam-dailies-directory "journal/")

  (defun +org-roam-get-node-id-from-title (id)
    "Get Id of node from title name"
    (car (car (org-roam-db-query
               [:select [id] :from nodes :where (= title $s1)]
               id))))
  ;; Example-
  ;; (+org-roam-get-node-id-from-title "homepage")
  ;; "6394F0D8-6B2C-43DD-B480-3C1B7C2C847D"

  (defun +org-roam-create-link-to-node (title)
    "Create link to node with specified id and text"
    (format "[[id:%s][%s]]" (+org-roam-get-node-id-from-title title) title))
  ;; Example-
  ;; (+org-roam-create-link-to-node "homepage")
  ;; "[[id:6394F0D8-6B2C-43DD-B480-3C1B7C2C847D][homepage]]"

  (setq org-roam-capture-templates
        '(
          ("d" "default" plain "%?" :target
           (file+head "%<%Y%m%d%H%M%S>.org" "
#+tags: %(+org-roam-create-link-to-node \"uncategorised\")
#+date_added: %(+org-roam-create-link-to-node \"%<%Y-%m-%d>\")
#+title: ${title}
")
           :unnarrowed t)
          ("l" "literature node" plain "%?" :target
           (file+head "%<%Y%m%d%H%M%S>.org" "
#+tags: %(+org-roam-create-link-to-node \"literature notes\")
#+filetags: :${source_type=article}:
#+date_added: %(+org-roam-create-link-to-node \"%<%Y-%m-%d>\")
#+title: ${title}

-----
Source: [weblink, local attachment link]
")
           :unnarrowed t)
          ("p" "project node" plain "%?" :target
           (file+head "%<%Y%m%d%H%M%S>.org" "
#+tags: %(+org-roam-create-link-to-node \"uncategorised\")
#+filetags: :${title}:
#+date_added: %(+org-roam-create-link-to-node \"%<%Y-%m-%d>\")
#+title: ${title}
")
           :unnarrowed t)
          ))

  (setq org-roam-dailies-capture-templates
        '(
          ("d" "default" entry "* %?" :target
           (file+head "%<%Y-%m-%d>.org" "
:PROPERTIES:
:ID: %(org-id-new)
:END:
#+tags: [[id:EC3D712A-F936-494B-8DFB-D379C57A2649][journal]]
#+title: %<%Y-%m-%d>
* Intention
What do I want to achive/focus on today?
* Tasks  :urgent:
** Done
* Habit Checklist
* Small wins
* Kaizen
* Log
"))
          ))

  (setq org-roam-completion-everywhere t)
  (define-key evil-normal-state-map (kbd "C-M-i") 'completion-at-point)
  (define-key evil-insert-state-map (kbd "C-M-i") 'completion-at-point)
  ;; (define-key evil-normal-state-map (kbd "C-M-i") #'completion-at-point)
  ;; (define-key evil-insert-state-map (kbd "C-M-i") #'completion-at-point)

  (spacemacs/declare-prefix "or" "org-roam")
  (spacemacs/set-leader-keys "ors" 'org-roam-db-sync)
                                        ; (spacemacs/set-leader-keys "orf" 'org-roam-node-find)
                                        ; (spacemacs/set-leader-keys "aorD" 'org-roam-dailies-map)
  ;; (spacemacs/declare-prefix-for-mode 'org-mode "mr" "org-roam")
  ;; (spacemacs/set-leader-keys-for-major-mode 'org-mode
  ;; "rl"  org-roam-buffer-toggle)

  (define-key evil-normal-state-map (kbd "C-c r f") 'org-roam-node-find)
  (define-key evil-insert-state-map (kbd "C-c r f") 'org-roam-node-find)
  (define-key evil-normal-state-map (kbd "C-c r i") 'org-roam-node-insert)
  (define-key evil-insert-state-map (kbd "C-c r i") 'org-roam-node-insert)
  (define-key evil-normal-state-map (kbd "C-c r d") 'org-roam-dailies-map)
  (define-key evil-insert-state-map (kbd "C-c r d") 'org-roam-dailies-map)
  (define-key evil-normal-state-map (kbd "C-c r l") 'org-roam-buffer-toggle)
  (define-key evil-insert-state-map (kbd "C-c r l") 'org-roam-buffer-toggle)
  ;; (define-key evil-normal-state-map (kbd "C-c r f") #'org-roam-node-find)
  ;; (define-key evil-insert-state-map (kbd "C-c r f") #'org-roam-node-find)
  ;; (define-key evil-normal-state-map (kbd "C-c r i") #'org-roam-node-insert)
  ;; (define-key evil-insert-state-map (kbd "C-c r i") #'org-roam-node-insert)
  ;; (define-key evil-normal-state-map (kbd "C-c r d") #'org-roam-dailies-map)
  ;; (define-key evil-insert-state-map (kbd "C-c r d") #'org-roam-dailies-map)
  ;; (define-key evil-normal-state-map (kbd "C-c r l") #'org-roam-buffer-toggle)
  ;; (define-key evil-insert-state-map (kbd "C-c r l") #'org-roam-buffer-toggle)

  (setq org-roam-node-display-template "${tags} ${title}")

  (add-to-list 'display-buffer-alist
               '("\\*org-roam\\*"
                 (display-buffer-in-direction)
                 (direction . right)
                 (window-width . 0.33)
                 (window-height . fit-window-to-buffer)))

  ;; Get `org-roam-preview-visit' and friends to replace the main window. This
  ;; should be applicable only when `org-roam-mode' buffer is displayed in a
  ;; side-window.
  ;; NOT WORKING.
  ;; (add-hook 'org-roam-mode-hook
  ;;           (lambda ()
  ;;             (setq-local display-buffer--same-window-action
  ;;                         '(display-buffer-use-some-window
  ;;                           (main)))))


  (org-roam-db-autosync-mode)

  )


;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(evil-want-Y-yank-to-eol nil)
   '(helm-completion-style 'helm)
   '(hl-todo-keyword-faces
     '(("TODO" . "#dc752f")
       ("NEXT" . "#dc752f")
       ("THEM" . "#2d9574")
       ("PROG" . "#4f97d7")
       ("OKAY" . "#4f97d7")
       ("DONT" . "#f2241f")
       ("FAIL" . "#f2241f")
       ("DONE" . "#86dc2f")
       ("NOTE" . "#b1951d")
       ("KLUDGE" . "#b1951d")
       ("HACK" . "#b1951d")
       ("TEMP" . "#b1951d")
       ("FIXME" . "#dc752f")
       ("XXX+" . "#dc752f")
       ("\\?\\?\\?+" . "#dc752f")))
   '(org-agenda-files
     '("/home/ashim/private/gtd/dreams/art/computer-games/fps/fps-dreams.org" "/home/ashim/private/gtd/dreams/art/graphic-design/graphic-design-dreams.org" "/home/ashim/private/gtd/dreams/comp/ai/ml/ml-sw-engg/tools/notebooks/jupyter/jupyter-dreams.org" "/home/ashim/private/gtd/dreams/comp/ai/ml/traditional-ml/traditional-ml-dreams.org" "/home/ashim/private/gtd/dreams/comp/big-data/hadoop/hadoop-dreams.org" "/home/ashim/private/gtd/dreams/comp/big-data/spark/spark-dreams.org" "/home/ashim/private/gtd/dreams/comp/db/relational/databases/mysql/mysql-dreams.org" "/home/ashim/private/gtd/dreams/comp/prog-lang/langs/jvm/scala/scala-dreams.org" "/home/ashim/private/gtd/dreams/comp/prog-lang/langs/python/python-dreams.org" "/home/ashim/private/gtd/dreams/comp/research-tools/learn/anki/anki-dreams.org" "/home/ashim/private/gtd/dreams/comp/research-tools/publish/docs/latex/beamer/beamer-dreams.org" "/home/ashim/private/gtd/dreams/comp/research-tools/publish/docs/latex/latex-dreams.org" "/home/ashim/private/gtd/dreams/comp/security/privacy/privacy-dreams.org" "/home/ashim/private/gtd/dreams/comp/software/libraries/protobuf/protobuf-dreams.org" "/home/ashim/private/gtd/dreams/comp/software/softwares/editors/emacs/org-mode/org-mode-dreams.org" "/home/ashim/private/gtd/dreams/comp/software/softwares/editors/emacs/spacemacs/spacemacs-dreams.org" "/home/ashim/private/gtd/dreams/comp/software/softwares/editors/emacs/emacs-dreams.org" "/home/ashim/private/gtd/dreams/comp/software/softwares/editors/vim/vim-dreams.org" "/home/ashim/private/gtd/dreams/comp/software/softwares/jq/jq-dreams.org" "/home/ashim/private/gtd/dreams/comp/software/softwares/messaging/matrix/matrix-dreams.org" "/home/ashim/private/gtd/dreams/comp/software/softwares/smartphone/automate/mobile-automate-app-dreams.org" "/home/ashim/private/gtd/dreams/comp/software/softwares/smartphone/mobile-dreams.org" "/home/ashim/private/gtd/dreams/comp/software/softwares/spreadsheet-software/excel/microsoft-excel-dreams.org" "/home/ashim/private/gtd/dreams/comp/software/softwares/ssh/ssh-dreams.org" "/home/ashim/private/gtd/dreams/comp/software/softwares/terminal-multiplexers/tmux/tmux-dreams.org" "/home/ashim/private/gtd/dreams/comp/software/theory/lsp/lsp-dreams.org" "/home/ashim/private/gtd/dreams/comp/sw-dev/impl-phase/tools/source-file-tools/giter8/giter8-dreams.org" "/home/ashim/private/gtd/dreams/comp/virtualisation/containerisation/tools/docker/docker-dreams.org" "/home/ashim/private/gtd/dreams/economics/business/accounting/accounting-dreams.org" "/home/ashim/private/gtd/dreams/economics/business/finance/investment/investment-dreams.org" "/home/ashim/private/gtd/dreams/economics/business/finance/finance-dreams.org" "/home/ashim/private/gtd/dreams/economics/business/business-dreams.org" "/home/ashim/private/gtd/dreams/history-geography/travel/travel-dreams.org" "/home/ashim/private/gtd/dreams/math/probability/probability-dreams.org" "/home/ashim/private/gtd/dreams/personal-mang/org/personal-finance/personal-finance-dreams.org" "/home/ashim/private/gtd/dreams/personal-mang/virtues/productivity/time-mang/time-mang-dreams.org" "/home/ashim/private/gtd/dreams/personal-mang/personal-mang-dreams.org" "/home/ashim/private/gtd/dreams/philosophy/philosophy-dreams.org" "/home/ashim/private/gtd/dreams/social-science/psychology/learning/habit/habit-dreams.org" "/home/ashim/private/gtd/birthdays.org" "/home/ashim/private/gtd/culture-dash.org" "/home/ashim/private/gtd/gtd-actions.org" "/home/ashim/private/gtd/gtd-dash.org" "/home/ashim/private/gtd/gtd-dreams.org" "/home/ashim/private/gtd/gtd-proj.org" "/home/ashim/private/gtd/tickler.org" "/home/ashim/ashim/projar/adkdd-2021/docs/todos.org" "/home/ashim/ashim/projbg/fitness/docs/todos.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204192501.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204192758.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204193016.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204203305.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204203321.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204213118.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204213131.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204213142.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204213255.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204213449.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204213524.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204213754.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204213844.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204213926.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204214134.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204214205.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204214215.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204214432.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204214514.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204214519.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204214527.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204214532.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204214537.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204214614.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204214751.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204215430.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250204215552.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250209155757.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250209155909.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250209160250.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250209160640.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250209195448.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250209201602.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250210010939.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250210011232.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250210012913.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250210013504.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250217015641.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250217015706.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250308214646.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250314174125.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250314174320.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250314174328.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250314211014.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250314211137.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250314211401.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250314212420.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250315005840.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250315005950.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250315010551.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250315010823.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250315011053.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250315011059.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250315011105.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250315011110.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250315011227.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250315011303.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250315011358.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250323025801.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250402212721.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250510184635.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250510184847.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250510185644.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250514161221.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250514161315.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250514161625.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250514161648.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250514162505.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250525025623.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20250528195501.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20251005093000.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20251005093028.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20251005093214.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20251005093251.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20251005093346.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20251005093906.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20251005094017.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20251005094138.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20251005094236.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20251005094337.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20251005094520.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20251005094743.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20251005095031.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20251005095722.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20251005095732.org" "/home/ashim/ashim/projbg/fun/nexus-war-origins/20251005100851.org" "/home/ashim/ashim/projbg/kaizen/docs/todos.org" "/home/ashim/ashim/projbg/kaizen/kaizen-org-roam/fleet/20240629031514.org" "/home/ashim/ashim/projbg/kaizen/kaizen-org-roam/journal/2024-06-28.org" "/home/ashim/ashim/projbg/kaizen/kaizen-org-roam/journal/2024-06-29.org" "/home/ashim/ashim/projbg/kaizen/kaizen-org-roam/websites/20240629030634.org" "/home/ashim/ashim/projbg/kaizen/kaizen-org-roam/20240629010028-kaizen_homepage.org" "/home/ashim/ashim/projbg/kaizen/kaizen-org-roam/20240629010443-workspace_org_roam_directory.org" "/home/ashim/ashim/projbg/kaizen/kaizen-org-roam/20240629033209.org" "/home/ashim/ashim/projbg/kaizen/kaizen-org-roam/20240629033510.org" "/home/ashim/ashim/projbg/kaizen/kaizen-org-roam/20240629033707.org" "/home/ashim/ashim/projbg/kaizen/kaizen-org-roam/20240629220418.org" "/home/ashim/ashim/projbg/kaizen/kaizen-org-roam/20240629220616.org" "/home/ashim/ashim/projbg/kaizen/org/inventory-mang/resources/kitchen.org" "/home/ashim/ashim/projbg/kaizen/scratch/notes.org" "/home/ashim/ashim/projbg/kaizen/yearly-review-2021/docs/todos.org" "/home/ashim/ashim/projfg/ads-learn/docs/todos.org" "/home/ashim/ashim/projfg/ml-learn/docs/ml-learn-scratch.org" "/home/ashim/ashim/projfg/ml-learn/docs/todos.org" "/home/ashim/ashim/projfg/ml-learn/dunkirk/analysis/electorial-bonds/docs/todos.org" "/home/ashim/ashim/projfg/ml-learn/traditional-ml/genai/llamaindex/src/data/org_roam/20250403200512.org" "/home/ashim/ashim/projfg/ml-learn/traditional-ml/genai/llamaindex/src/data/org_roam/20250411000428.org" "/home/ashim/ashim/projfg/ml-learn/traditional-ml/genai/llamaindex/src/data/org_roam/20250411001704.org" "/home/ashim/ashim/projfg/ml-learn/traditional-ml/genai/llamaindex/src/data/org_roam/20250411003226.org" "/home/ashim/clinic/bunny-whites/admin/todos.org" "/home/ashim/clinic/bunny-whites/bizdev/new-clinic-mahalunge/todos.org" "/home/ashim/clinic/bunny-whites/bizdev/new-clinic-nigdi/todos.org" "/home/ashim/clinic/bunny-whites/bizdev/todos.org" "/home/ashim/clinic/bunny-whites/brand/marketing/website/todos.org" "/home/ashim/clinic/bunny-whites/brand/marketing/todos.org" "/home/ashim/clinic/bunny-whites/clinical/todos.org" "/home/ashim/clinic/bunny-whites/finance/todos.org" "/home/ashim/family/projfg/baby/docs/todos.org"))
   '(org-babel-load-languages '((python . t) (emacs-lisp . t) (dot . t) (shell . t)))
   '(org-export-backends '(ascii beamer html icalendar latex odt))
   '(org-fontify-done-headline nil)
   '(org-fontify-todo-headline nil)
   '(org-roam-completion-everywhere t)
   '(package-selected-packages
     '(cliphist git-link git-messenger git-modes git-timemachine gitignore-templates helm-git-grep orgit-forge orgit forge ghub closql treepy smeargle treemacs-magit magit git-commit with-editor compat lsp-docker yaml import-js grizzl js-doc js2-refactor multiple-cursors livid-mode nodejs-repl npm-mode skewer-mode js2-mode tern org-roam-ui websocket org-roam magit-section emacsql dash web-mode web-beautify tagedit slim-mode scss-mode pug-mode prettier-js simple-httpd helm-css-scss haml-mode emmet-mode web-completion-data add-node-modules-path yapfify stickyfunc-enhance sphinx-doc pytest pyenv-mode pydoc py-isort poetry transient pippel pipenv pyvenv pip-requirements nose lsp-python-ms lsp-pyright live-py-mode importmagic epc ctable concurrent deferred helm-pydoc helm-gtags helm-cscope xcscope ggtags dap-mode lsp-treemacs bui lsp-mode markdown-mode cython-mode counsel-gtags counsel swiper ivy company-anaconda blacken anaconda-mode pythonic leuven-theme yasnippet-snippets org-rich-yank org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-mime org-download org-contrib org-cliplink htmlize helm-org-rifle helm-company helm-c-yasnippet gnuplot fuzzy flyspell-correct-helm flyspell-correct evil-org company auto-yasnippet yasnippet auto-dictionary ac-ispell auto-complete ws-butler writeroom-mode winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package undo-tree treemacs-projectile treemacs-persp treemacs-icons-dired treemacs-evil toc-org symon symbol-overlay string-inflection string-edit spaceline-all-the-icons restart-emacs request rainbow-delimiters quickrun popwin pcre2el password-generator paradox overseer org-superstar open-junk-file nameless multi-line macrostep lorem-ipsum link-hint inspector info+ indent-guide hybrid-mode hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-xref helm-themes helm-swoop helm-purpose helm-projectile helm-org helm-mode-manager helm-make helm-ls-git helm-flx helm-descbinds helm-ag google-translate golden-ratio font-lock+ flycheck-package flycheck-elsa flx-ido fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-textobj-line evil-surround evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-escape evil-ediff evil-easymotion evil-collection evil-cleverparens evil-args evil-anzu eval-sexp-fu emr elisp-slime-nav editorconfig dumb-jump drag-stuff dotenv-mode dired-quick-sort diminish devdocs define-word column-enforce-mode clean-aindent-mode centered-cursor-mode auto-highlight-symbol auto-compile aggressive-indent ace-link ace-jump-helm-line))
   '(pdf-view-midnight-colors '("#fdf4c1" . "#282828"))
   '(safe-local-variable-values
     '((org-roam-db-location . "~/ashim/projbg/kaizen/kaizen-org-roam/org-roam.db")
       (org-roam-directory . "~/ashim/projbg/kaizen/kaizen-org-roam")
       (org-roam-db-location . "~/ashim/projbg/fun/nexus-war-origins/org-roam.db")
       (org-roam-directory . "~/ashim/projbg/fun/nexus-war-origins")
       (org-roam-capture-templates
        ("d" "default" plain "%?" :target
         (file+head "%<%Y%m%d%H%M%S>.org" "\12#+tags: %(+org-roam-create-link-to-node \"uncategorised\")\12#+date_added: %(+org-roam-create-link-to-node \"%<%Y-%m-%d>\")\12#+title: ${title}\12")
         :unnarrowed t))
       (org-roam-capture-templates
        ("d" "default" plain "%?" :target
         (file+head "%<%Y%m%d%H%M%S>.org" "\12\11\11\11\11\11\11  #+tags: %(+org-roam-create-link-to-node \"uncategorised\")\12\11\11\11\11\11\11  #+date_added: %(+org-roam-create-link-to-node \"%<%Y-%m-%d>\")\12\11\11\11\11\11\11  #+title: ${title}\12\11\11\11\11\11\11  ")
         :unnarrowed t))
       (javascript-backend . tide)
       (javascript-backend . tern)
       (javascript-backend . lsp)
       (eval when
             (locate-library "rainbow-mode")
             (require 'rainbow-mode)
             (rainbow-mode))
       (org-roam-dailies-directory . "journal/")
       (org-roam-capture-templates
        ("d" "default" plain "%?" :target
         (file+head "%<%Y%m%d%H%M%S>.org" "#+title: ${title}\12")
         :unnarrowed t)
        ("f" "fleeting" plain "%?" :target
         (file+head "fleet/%<%Y%m%d%H%M%S>.org" "#+TITLE: ${title}\12")
         :unnarrowed t))
       (org-roam-capture-templates
        ("d" "default" plain "%?" :target
         (file+head "%<%Y%m%d%H%M%S>.org" "#+title: ${title}")
         :unnarrowed t)
        ("f" "fleeting" plain "%?" :target
         (file+head "websites/%<%Y%m%d%H%M%S>.org" "#+ROAM_KEY: ${ref}\12#+TITLE: ${title}")
         :unnarrowed t))
       (org-roam-capture-templates
        ("d" "default" plain "%?" :target
         (file+head "%<%Y%m%d%H%M%S>.org" "#+title: ${title}\12")
         :unnarrowed t)
        ("f" "fleeting" plain "%?" :file-name "websites/%<%Y%m%d%H%M%S>.org" :head "#+ROAM_KEY: ${ref}\12#+TITLE: ${title}\12" :unnarrowed t))
       (org-roam-capture-templates
        ("d" "default" plain "%?" :target
         (file+head "%<%Y%m%d%H%M%S>.org" "#+title: ${title}\12")
         :unnarrowed t))
       (org-roam-capture-templates
        ("d" "default" plain "%?" :target
         (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\12")
         :unnarrowed t))
       (org-roam-capture-templates quote
                                   (("d" "default" plain "%?" :target
                                     (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\12")
                                     :unnarrowed t)))
       (org-roam-capture-templates
        '(("d" "default" plain "%?" :target
           (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\12")
           :unnarrowed t)))
       (org-roam-capture-templates
        '(("d" "default" plain "%?" :if-new
           (file+head "%<%Y%m%d%H%M%S>.org" "#+title: ${title}\12")
           :unnarrowed t)))
       (org-roam-capture-templates
        '(("d" "default" plain "%?" :target
           (file+head "%<%Y%m%d%H%M%S>.org" "#+title: ${title} ")
           :unnarrowed t)))
       (org-roam-capture-templates
        '(("d" "default" plain "%?" :target
           (file+head "%<%Y%m%d%H%M%S>.org" "#+title: ${title} ")
           :unnarrowed t)
          ("f" "fleeting" plain "%?" :file-name "websites/%<%Y%m%d%H%M%S>.org" :head "#+ROAM_KEY: ${ref}\12#+TITLE: ${title} " :unnarrowed t)))
       (org-roam-capture-templates
        '(("d" "default" plain "%?" :target
           (file+head "%<%Y%m%d%H%M%S>.org" "#+title: ${title}")
           :unnarrowed t)
          ("f" "fleeting" plain "%?" :file-name "websites/%<%Y%m%d%H%M%S>.org" :head "#+ROAM_KEY: ${ref}\12#+TITLE: ${title}" :unnarrowed t))))))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   )
  )
