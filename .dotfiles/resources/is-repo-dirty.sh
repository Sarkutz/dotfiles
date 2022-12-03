#!/usr/bin/env bash

paths=( \
    ~/ashim/  \
    ~/pubmatic/  \
    ~/clinic/  \
    ~/family/  \
    ~/private/gtd/  \
    ~/private/knowl/  \
)

function is_repo_dirty() {
    path="$1"
    if [[ -n $( git --git-dir="$path" --work-tree=$( dirname "$path" ) status --short ) ]]; then
        echo "$path"
    fi
}
export -f is_repo_dirty

for p in "${paths[@]}"; do
    find "$p" -name .git -type d -print0 | xargs -0 -I{} bash -c "is_repo_dirty {}"

    # find "$p" \( -path "$p/projar" -o -path "$p/projfg" -o -path "$p/projbg"  \
    #     -o -path "$p/projint" \) -prune -o -name .git -type d -print0 |  \
    #     xargs -0 -I{} bash -c "is_repo_dirty {}"
done

