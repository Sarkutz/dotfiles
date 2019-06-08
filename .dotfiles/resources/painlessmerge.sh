#!/usr/bin/env bash

# Painless Merge
# ==============
# Implements "Painless Merge Conflict Resolution in Git" [1] using vimdiff.
# Also see [2].
# 
# [1]: http://blog.wuwon.id.au/2010/09/painless-merge-conflict-resolution-in.html
# [2]: http://vim.wikia.com/wiki/A_better_Vimdiff_Git_mergetool


if [[ -z $@ || $# != "5" ]] ; then
echo -e "Usage: $0 \$EDITOR \$BASE \$LOCAL \$REMOTE \$MERGED"
echo "EDITOR must support flags supported by vimdiff"
exit 1
fi
 
cmd=$1
BASE="$2"
LOCAL="$3"
REMOTE="$4"
MERGED="$5"
printf -v QBASE '%q' "${BASE}"
printf -v QLOCAL '%q' "${LOCAL}"
printf -v QREMOTE '%q' "${REMOTE}"
printf -v QMERGED '%q' "${MERGED}"
 
# Fire up vimdiff
$cmd -f -R -d "${BASE}" "${LOCAL}" \
    -c ":tabe $BASE | vert diffs $REMOTE"  \
    -c ":set noro | tabe $LOCAL | vert diffs $MERGED | vert diffs $REMOTE"
EC=$?
 
exit $EC
