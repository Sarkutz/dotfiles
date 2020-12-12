
###############
Knowledge Bases
###############

.. contents::
   :depth: 2


************
Introduction
************

This folder contains configs. and resources for managing knowledge bases.

Several knowledge bases are maintained to document knowledge.  For example,
the main knowl is stored in :code:`$DOTFILES_KNOWL` (env var).  Similarly,
there is a knowledge base in each workspace.

Each knowledge base (aka :dfn:`knowl`) is managed using `Sphinx
<http://www.sphinx-doc.org/>`__.  And hosted on localhost using Nginx.


************
Dependencies
************

.. list-table:: Dependencies
   :widths: auto
   :header-rows: 1

   * - Dependency
     - Used By
     - Installation

   * - PHP-FPM
     - Required to serve PHP files using Nginx.
     - System's package manager.

       On Mac OS-

       - :code:`brew install php@7.4` (change version as required)
       - Update :file:`/usr/local/etc/php/7.4/php-fpm.d/www.conf`::

            user = ashim
            group = staff
            listen = /usr/local/var/run/php-fpm.sock

            ; If required
            listen.owner = ashim
            listen.group = staff
            listen.mode = 0660

        - Start PHP-FPM: :code:`brew services start php@7.4`

   * - Nginx
     - Required to serve knowl on localhost.
     - System's package manager.

       On Mac OS, config files are in :file:`/usr/local/etc/nginx/`.

       See `Install Knowl Resources`_.

   * - Sphinx
     - Required to manage knowl.
     - PyPI::

          pip install -U sphinx

       This is already included in :file:`sphinx.requirements.txt`.

   * - `Sphinx Book Theme
       <https://sphinx-book-theme.readthedocs.io/en/latest/index.html>`__
     - Required for Sphinx.
     - PyPI::

          pip install sphinx-book-theme

       This is already included in :file:`sphinx.requirements.txt`.


***********************
Install Knowl Resources
***********************

Copy :file:`nginx-localhost.conf` into the nginx config folder and restart
nginx.

.. note::

   You might need to update the paths in :file:`nginx-localhost.conf`.

Access website at `http://127.0.0.1:8080 <http://127.0.0.1:8080>`__.


**************
Setup Overview
**************

.. list-table:: Resources Provided
   :widths: 1
   :header-rows: 1

   * - Resource
     - Notes

   * - :file:`nginx-localhost.conf`
     - Nginx config file for localhost.  This needs to be installed manually
       as per steps in `Install Knowl Resources`_.

   * - :file:`index.html`, :file:`phpinfo.php`
     - Localhost website files.  These are copied to path in
       :code:`$DOTFILES_WWW` env var by :file:`setup-folders.sh`

