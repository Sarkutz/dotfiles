# dev.sh
#
# *Contains BASH alias spaces for development that can be used all machines*.
#
# Usage: Source this file, then call ``act_<name>_alias_space`` to activate the <name> Alias Space.
#
# Prerequisite:
# - $DOTFILES is set
# - base.sh
# - utils/bashrc-utils.sh

# Pre-requisites
# ==============

source "${DOTFILES}/base.sh"


# Utility Functions
# =================

function prefix_to_alias_spaces_variable() {
  alias_space_name="$1"

  usage='prefix_to_alias_space_variable: Add Alias Space name as the first entry in DOTFILES_ALIAS_SPACES env. var.
NOTE: Updates the DOTFILES_ALIAS_SPACES env. var.
USAGE: prefix_to_alias_space_variable <alias-space-name-to-prefix>'
  if [[ $# -ne 1 ]]; then
    echo "$usage"
    return 1
  fi

  if [[ -z "$DOTFILES_ALIAS_SPACES" ]]; then
    export DOTFILES_ALIAS_SPACES="$alias_space_name"
  else
    export DOTFILES_ALIAS_SPACES="$( prefix_unique "$DOTFILES_ALIAS_SPACES" "$alias_space_name" ':' )"
  fi
}


function remove_from_alias_space_variable() {
  alias_space_name="$1"

  usage='remove_from_alias_space_variable: Remove a Alias Space name from DOTFILES_ALIAS_SPACES env. var.
NOTE: Updates the DOTFILES_ALIAS_SPACES env. var.
USAGE: remove_from_alias_space_variable <alias-space-name-to-remove>'
  if [[ $# -ne 1 ]]; then
    echo "$usage"
    return 1
  fi

  new_path="$( cd "$DOTFILES/utils" && \
      python -c "import bashrcutils; print(bashrcutils.remove_token('$DOTFILES_ALIAS_SPACES', '$alias_space_name', ':'))")"
  [[ $? -ne 0 ]] && return 1

  export DOTFILES_ALIAS_SPACES="$new_path"
}


# Alias Spaces
# ============

# function act_foo_alias_space() {
#   prefix_to_alias_spaces_variable foo
#
#   alias foo=foo
#   function bar() {}
#
#   function deact_foo_alias_space() {
#     remove_from_alias_space_variable foo
#
#     unalias foo
#     unset -f bar
#
#     unset -f deact_foo_alias_space
#   }
# }


function act_c_alias_space() {
  prefix_to_alias_spaces_variable c

  function deact_c_alias_space() {
    remove_from_alias_space_variable c

    unset -f deact_c_alias_space
  }
}


function act_python_alias_space() {
  prefix_to_alias_spaces_variable py

  function act_conda() {
    conda_path="$DOTFILES_SOFTWARE_STANDALONE/miniconda3/"
    __conda_setup="$("$conda_path/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$conda_path/etc/profile.d/conda.sh" ]; then
            . "$conda_path/etc/profile.d/conda.sh"
        else
            export PATH="$conda_path/bin:$PATH"
        fi
    fi
    unset __conda_setup

    echo 'Logout to deactivate conda'
  }

  function python_venv_activate() {
      env_name="$1"
      env_path="$DOTFILES_PYENVS"
  
      usage='python_venv_activate: Activate `env_name` Python Virtual Environment.
  USAGE: python_venv_activate <env-name>'
      if [[ $# -eq 0 ]]
      then
          echo "$usage"
          echo -e "Specify any one venv: ${BASH_COLOR_EM1}" $( ls $env_path ) ${BASH_COLOR_RESET}
          return 1
      fi
  
      source "${env_path}/${env_name}/bin/activate"
  }

  # dve (Virtual Env): Activate Python Virtual Env.
  alias dve=python_venv_activate


  function deact_python_alias_space() {
    remove_from_alias_space_variable py

    [[ $( which conda ) ]] && conda deactivate
    unset -f act_conda

    unset -f python_venv_activate
    unalias dve

    unset -f deact_python_alias_space
  }
}


function act_java_alias_space() {
  prefix_to_alias_spaces_variable java

  function deact_java_alias_space() {
    remove_from_alias_space_variable java

    unset -f deact_java_alias_space
  }
}


function act_scala_alias_space() {
  act_java_alias_space
  prefix_to_alias_spaces_variable scala

  spark_bin_dir="$DOTFILES_SOFTWARE_STANDALONE/spark-2.4.0-bin-hadoop2.7/bin"
  prefix_to_path "$spark_bin_dir"

  function deact_scala_alias_space() {
    remove_from_alias_space_variable scala

    remove_from_path "$spark_bin_dir"

    [[ $( type -t deact_java_alias_space ) == 'function' ]] && deact_java_alias_space
    unset -f deact_scala_alias_space
  }
}


function act_go_alias_space() {
  prefix_to_alias_spaces_variable go

  go_bin_dir="${DOTFILES_REPOS}/github.com/golang/go/bin/"
  prefix_to_path "$go_bin_dir"

  # Go path
  if [[ -d ${HOME}/go ]]; then
    export GOPATH="${HOME}/go"
    prefix_to_path "${GOPATH}/bin"
  fi

  # No need to set GOROOT as it is already set to the root used during the
  # Go build.

  # goplay: Open Go in Docker for quick experiments.
  function goplay()
  {
      path='$DOTFILES_PERSONAL_WORKSPACE/sandbox/prog-lang/golang/codes/docker-volume'
      dest_path='/go/src'
      cd "$path"
      echo "Mounted $path to $dest_path in container"
      docker container run -it -v "${path}:${dest_path}" golang:alpine
      docker container ls -a
      echo 'docker container rm CONTAINER_ID'
  }

  function deact_go_alias_space() {
    remove_from_alias_space_variable go

    remove_from_path "$go_bin_dir"

    if [[ -d ${HOME}/go ]]; then
      remove_from_path "${GOPATH}/bin"
      export GOPATH=
    fi

    unset -f goplay

    unset -f deact_go_alias_space
  }
}


function act_r_alias_space() {
  prefix_to_alias_spaces_variable r

  function deact_r_alias_space() {
    remove_from_alias_space_variable r

    unset -f deact_r_alias_space
  }
}


function act_js_alias_space() {
  prefix_to_alias_spaces_variable js

  # kjsb: JS Beautifier
  alias kjsb='python $DOTFILES_SOFTWARE_INSTALL_PREFIX/bin/jsbeautify.py'

  # jsplay: Open JS in Docker for quick experiments.
  function jsplay()
  {
      port=${1:-8090}
      path='$DOTFILES_WWW/try'
      dest_path='/usr/share/nginx/html'
      cd "$path"
      echo "Mounted $path to $dest_path in container"
      docker container run -d -p ${port}:80 -v "${path}:${dest_path}" nginx
      docker container ls -a
      echo "http://localhost:${port}/"
      echo 'docker container rm CONTAINER_ID'
  }

  function deact_js_alias_space() {
    remove_from_alias_space_variable js

    unalias kjsb
    unset -f jsplay

    unset -f deact_js_alias_space
  }
}
