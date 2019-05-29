set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

let g:python_host_prog="$DOTFILES_PYENVS/nvimpy2/bin/python"
let g:python3_host_prog="$DOTFILES_PYENVS/nvim/bin/python3"

source ~/.vimrc
