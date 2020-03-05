#!/usr/bin/env bash

filename="$1"

shopt -s expand_aliases

# Fetch aliases
if [[ $(uname) == 'Darwin' ]]; then
    # scc (Copy Clipboard)
    alias scc=pbcopy
    # spc (Paste Clipboard)
    alias spc=pbpaste
else
    # scc (Copy Clipboard)
    alias scc='xclip -i -selection clipboard'
    # spc (Paste Clipboard)
    alias spc='xclip -o -selection clipboard'
fi

[[ -z $( which rst2confluence ) ]] && echo 'act_python_alias_space; dve doc' && exit 1

rst2confluence "$filename" | scc

shopt -u expand_aliases
