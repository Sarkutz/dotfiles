
#######
Backups
#######

Design and resources for data sync and backup (including to cloud).

.. contents:: Contents
   :depth: 1
   :local:


************
Dependencies
************

.. list-table:: Dependencies
   :widths: auto
   :header-rows: 1

   * - Dependency
     - Used by
     - Installation Source
     - Notes

   * - Syncthing
     -
     -
     - See main README of this repository for details.

   * - `Borg Backups <https://borgbackup.readthedocs.io/>`__
     - Backups.
     - System's package manager.
     - Only required on `Home Server`_.


************
Installation
************

Install `dependencies`_.

Configure Syncthing as per `Config: Syncthing`_.  Setup Syncthing folder as
per `Design: Folder Level`_.  If additional folders need to be backed up,
setup a Syncthing folder having the appropriate `Syncthing Backup Types`_.

On the `home server`_ only, configure Borg as per `Config: Borg Backups`_
(move scripts provided in this folder manually).  Setup backup and cloud as
per `Design: Folder Level`_ and `Design: Syncthing Folders`_.


******
Design
******

Design Considerations
=====================

- Data availability

  - Backup: No data loss
  - Sync: Easy access to appropriate data on appropriate devices.

- Privacy and control over data

- Security


Architecture
============

- All Devices push data to `home server`_ using Syncthing folders.

- Home Server is setup like a `Workstation`_.  Hence, it is in sync with other
  Workstations (through Syncthing) and can backup their current state.

- Home Server backups data synced with it.

  - It backsup to it's local disks automatically every hour.  This guards
    against data corruption and accidental file deletions by any  Syncthing
    client.
  - The home server also backups to External Harddisk(s) weekly (manually
    every Sunday) using Borg.

- Home Server can store backups for other users if they Sync their data to the
  Home Server.  Please see `Syncthing Backup Types`_.

Workstation
-----------

A workstation is any devices on which i can do my work.  It has all the
required workspaces and resources required for work.  All workstations are
synced with each other through Syncthing.  Hence, i can hand-over and pick up
work on any workstation.

Home Server
-----------

Home Server is a single server that is responsible for creating all Borg
backups.

All data that needs to be backed up is aggregated to the home server through
Syncthing.  Hence, home server should be accessable to all other devices.
The home server backsup all data to multiple Borg repositories.

Syncthing Backup Types
----------------------

Home Server can store backups for other users.  Ask users to share the
folder that they want to backup as a Syncthing folder.  The home server
picks up the data from the Syncthing folder and backs it up.

Backups performed for other users can be of three types-

- Secret: Secrets like passwords.
- Private (default): Data that shouldn't be disclosed publicly.  (Hence, can't
  go to the cloud.)
- Public: Data that can go to cloud.

This type decides the backup policy.  Please see `Design: Syncthing Folders`_
for details on the backup policy.


Design: Folder Level
====================

*Applies to all devices (workstation specific folders only apply to
workstations)*.

.. list-table:: Design: Folder Level
   :widths: auto
   :header-rows: 1

   * - Path
     - Sync
     - Backup
     - Cloud
     - Notes

   * - Workspaces
     - To workstations only
     - Yes
     - No
     -

   * - :file:`private/anki/`
     - To workstation only
     - Yes
     - No
     - Sync folder and all it's contents.

   * - :file:`private/knowl/`
     - To workstation only
     - Yes
     - No
     - Sync folder and all it's contents.

   * - :file:`private/diary/`
     - To workstation only
     - Yes
     - No
     - Sync folder and all it's contents.

   * - :file:`private/gtd/`
     - To all
     - Yes
     - No
     - Sync folder and all it's contents.

   * - :file:`private/orgzly/`
     - To all
     - Yes
     - No
     - Sync folder and all it's contents.

   * - :file:`private/zotero/`
     - To all
     - Yes
     - No
     - Sync folder and all it's contents.

   * - :file:`private/active/`
     - To all
     - Yes
     - No
     - Sync folder and all it's contents.

   * - :file:`private/ghosh-family/`
     - To all
     - Yes
     - No
     - Sync folder and all it's contents.

   * - :file:`public/`
     - To workstation only
       :code:`.stignore` :code:`public/www`.
     - Yes
     - Yes
     - Sync/backup :file:`public/website/online/`.  Don't sync/backup
       :file:`public/www` as each workstation might want to host it's own
       version.  

   * - :file:`resources/`
     - To workstation only.
       :code:`.stignore` :code:`/repos`, :code:`/software`
     - Yes
     - ???
     - Sync/backup :file:`resources/data` and :file:`resources/ashim`.  Don't
       sync/backup :file:`resources/repos` or :file:`resources/software`.

   * - :file:`downloads/`
     - No
     - No
     - No
     -


Design: Syncthing Folders
=========================

:file:`public/file-share` is deprecated.  Place the folder anywhere you want
and configure it's path in Syncthing.

.. note::

   Deprecated: Don't sync/backup :file:`public/file-share`.  Instead
   sync/backup it's subfolders as per below design.

.. list-table:: Design: Syncthing Folders
   :widths: auto
   :header-rows: 1

   * - Path
     - Backup
     - Cloud
     - Notes

   * - :file:`backups/file-share/secret/`
     - Yes
     - No
     - Contains secret `Syncthing Backup Types`_.  For `home server`_ only.

   * - :file:`backups/file-share/private/`
     - Yes
     - No
     - Contains private `Syncthing Backup Types`_.  For `home server`_ only.

   * - :file:`backups/file-share/public/`
     - Yes
     - Yes
     - Contains public `Syncthing Backup Types`_.  For `home server`_ only.


**************
Configurations
**************

Config: Syncthing
=================

Syncthing app setup (for all Syncthing clients)-

- Turn OFF Relaying and Crash Reporting.
- Make folder created for backups only "Send Only" and "Receive Only".
- Let Vim swap files (and similar "lock" files) be shared so that others
  know if this file is being edited on another device.

Syncthing Shares (for all Syncthing clients)-

- Syncthing folders' local path could be anywhere.
- Setup folder sharing as per `Design: Folder Level`_ and
  `Design: Syncthing Folders`_.

Nested Syncthing folders-

- Add the nested subfolders to :code:`.stignore` and share them as a separate
  Syncthing folder.  Precise control on who to share with.
- Share the "super" folder.  The destination ignores the subfolder by adding
  it in :code:`.stignore`.  Destination can ignore unnecessary (perhaps large)
  folders.


Config: Borg Backups
====================

- Setup folder backups as per `Design: Folder Level`_ and
  `Design: Syncthing Folders`_.

Config: Borg Backups: Backup Resources
--------------------------------------

*On home server only*.

.. list-table:: Folder hierarchy of backup resources
   :widths: auto
   :header-rows: 1

   * -  Folder
     - Description

   * - :file:`backups/`
     - All backup resources are stored here.  For `home server`_ only.

   * - :file:`backups/borg/`
     - `home server`_'s local Borg repository goes here.

   * - :file:`backups/file-share/{secret,private,public}`
     - See `Design: Syncthing Folders`_.

Borg exclude patterns (:code:`--exclude`) for all backups::

   *.pyc
   *.sw?
   .stversions  # Syncthing
   !.stignore
   */knowl/build
   */wiki/build

Deprecated::

   .stfolder  # Required to tell Synthing to manage this folder.
              # (It's an empty folder.)

Config: Borg Backups: Repositories
----------------------------------

.. note::

   Before taking bakcups, verify that sync is good.

   - Verify that sync in "Up to Date" (using the Syncthing Web UI).

   - Verify no sync conflicts::

        find /home/ashim/private/ -name '*sync-conflict*'
        find /home/ashim/public/ -name '*sync-conflict*'
        find /home/ashim/resources/ -name '*sync-conflict*'
        find /home/ashim/public/file-share/ -name '*sync-conflict*'
        find /home/ashim/ashim/ -name '*sync-conflict*'
        find /home/ashim/clinic/ -name '*sync-conflict*'
        find /home/ashim/pubmatic/ -name '*sync-conflict*'


.. rubric:: Ashim All Daily

- Repository: :file:`/home/ashim/backups/borg/ashim-all-daily`

- Script: :file:`backup-ashim-all-daily.sh`

- Run hourly (automatically through crontab)::

     50 * * * * /bin/bash /home/ashim/backups/backup-ashim-all-daily.sh >/home/ashim/backups/backup-ashim-all-daily.log 2>&1

- Prune: Keep 24 hours and 90 day::

     --keep-hourly   24
     --keep-daily    90

- Common Commands::

     borg list /home/ashim/backups/borg/ashim-all-daily | tail -n 50
     less /home/ashim/backups/backup-ashim-all-daily.log


.. rubric:: Ashim All Weekly (to iomega external HDD)

- Repository: :file:`/media/ashim/Ghosh4881/Ashim/backups/borg/all-weekly`

- Script: :file:`backup-ashim-all-weekly-to-iomega.sh`

- Run weekly (manually on Sunday)

- Prune::

     --keep-weekly     12
     --keep-monthly   -1

- Common Commands::

     ls -l /media/ashim/Ghosh488/Ashim/backups/borg
     borg list /media/ashim/Ghosh488/Ashim/backups/borg/all-weekly | tail -n 50

     /bin/bash /home/ashim/backups/backup-ashim-all-weekly-to-iomega.sh >/home/ashim/backups/backup-ashim-all-weekly-to-iomega.log 2>&1 &
     tail -f /home/ashim/backups/backup-ashim-all-weekly-to-iomega.log

     less /home/ashim/backups/backup-ashim-all-weekly-to-iomega.log


.. rubric:: Ashim All Weekly (to Seagate external HDD)

- Repository: :file:`/media/ashim/Seagate Backup Plus Drive/Ashim/backups/borg/all-weekly`

- Script: :file:`backup-ashim-all-weekly-to-seagate.sh`

- Run weekly (manually on Sunday)

- Prune::

     --keep-weekly     12
     --keep-monthly   -1

- Common Commands::

     ls -l '/media/ashim/Seagate Backup Plus Drive/Ashim/backups/borg/'
     borg list '/media/ashim/Seagate Backup Plus Drive/Ashim/backups/borg/all-weekly' | tail -n 50

     /bin/bash /home/ashim/backups/backup-ashim-all-weekly-to-seagate.sh >/home/ashim/backups/backup-ashim-all-weekly-to-seagate.log 2>&1 &
     tail -f /home/ashim/backups/backup-ashim-all-weekly-to-seagate.log

     less /home/ashim/backups/backup-ashim-all-weekly-to-seagate.log


**************
Config: Rclone
**************

TODO: Study and create plan for "Cloud".

