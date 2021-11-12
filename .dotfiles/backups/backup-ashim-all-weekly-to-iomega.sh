#!/bin/sh

# Setting this, so the repo does not need to be given on the commandline:
export BORG_REPO='/media/ashim/Ghosh488/Ashim/backups/borg/all-weekly'

# See the section "Passphrase notes" for more infos.
# export BORG_PASSPHRASE='XYZl0ngandsecurepa_55_phrasea&&123'

BORG='/home/ashim/resources/software/installed/bin/borg'

# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

info "Starting backup"

# Backup the most important directories into an archive named after
# the machine this script is currently running on:

$BORG create                        \
    --verbose                       \
    --filter AME                    \
    --list                          \
    --stats                         \
    --show-rc                       \
    --exclude-caches                \
    --exclude '*.pyc'               \
    --exclude '*.sw?'               \
    --exclude '.stversions'         \
    --exclude '!.stignore'          \
    --exclude '*/knowl/build'       \
    --exclude '*/wiki/build'        \
                                    \
    ::'ashim_all_weekly_{now:%Y-%m-%d}' \
     ~/private/                      \
     ~/public/                       \
     ~/archives/                     \
     ~/storage/                      \
     ~/resources/ashim/              \
     ~/resources/data/               \
     ~/ashim/                        \
     ~/clinic/                       \
     ~/pubmatic/                     \
     ~/family/                       \

backup_exit=$?

info "Pruning repository"

# Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machines' archives also:

$BORG prune                         \
    --list                          \
    --prefix 'ashim_all_weekly_'\
    --show-rc                       \
    --keep-weekly     12            \
    --keep-monthly   -1             \

prune_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 0 ]; then
    info "Backup and Prune finished successfully"
elif [ ${global_exit} -eq 1 ]; then
    info "Backup and/or Prune finished with warnings"
else
    info "Backup and/or Prune finished with errors"
fi

exit ${global_exit}

