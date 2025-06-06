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
      env_path="${2:-$DOTFILES_PYENVS}"
  
      usage='python_venv_activate: Activate `env_name` Python Virtual
Environment.
USAGE: python_venv_activate <env_name> [env_dir]
- env_name: Name of venv folder
- env_dir (optional): Path to the directory containing the venv (default: 
  $DOTFILES_PYENVS)'
      if [[ $# -eq 0 ]]
      then
          echo "$usage"
          echo -e "Specify any one venv: ${BASH_COLOR_EM1}" $( ls $env_path ) ${BASH_COLOR_RESET}
          return 1
      fi
  
      source "${env_path}/${env_name}/bin/activate"
  }

  function _complete_python_venv_activate() {
    local cur
    cur="${COMP_WORDS[COMP_CWORD]}"
    venv_list="$( ls $DOTFILES_PYENVS )"
    COMPREPLY=( $( compgen -W "$venv_list" -- $cur ) )
  }
  complete -F _complete_python_venv_activate python_venv_activate

    function toconflu() {
        usage='toconflu: Convert specified Sphinx path to Confluence storage
format and copy it to the clipboard.  This must be executed from the directory
containing Sphinxs Makefile.
USAGE: toconflu sphinx/path/to/file/wo/ext
Example: toconflu projfg/foo/doc/conflu/proj-dash'

        if [[ $# -ne 1 ]]
        then
            echo "$usage"
            return 1
        fi
        file_path="$1"

        # Add the extension here: confluencebuilder replaces mathjax with
        # pngmath, and we would like to use mathjax whenever possible.
        sphinx-build -b confluence -D extensions=sphinxcontrib.confluencebuilder \
            source/ build/confluence source/${file_path}.rst \
            && cat build/confluence/${file_path}.conf \
            | python $DOTFILES/utils/conflu-user-name-to-link.py \
            | scc
    }

    function ipynb_open() {
        usage='ipynb_open: Open current directory or specified file in
Jupyter notebook.
USAGE: ipynb_open [relative/path/to/notebook.ipynb]
Examples-
- ipynb_open
- ipynb_open foo.ipynb
Assumptions-
- Jupyter notebook server must already be running at "http://localhost:8888".
  The server should have been started in the home directory.
- If path to notebook is specified, it must be a relative path.'

        pwd=$( dirs ) && open "http://localhost:8888/tree${pwd:1}/$1"
    }

  function deact_python_alias_space() {
    remove_from_alias_space_variable py

    [[ $( which conda ) ]] && conda deactivate
    unset -f act_conda

    unset -f python_venv_activate
    complete -r python_venv_activate
    unset -f _complete_python_venv_activate

    unset -f toconflu
    unset -f ipynb_open

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

  export HADOOP_HOME="$DOTFILES_SOFTWARE_STANDALONE/hadoop/hadoop-3.4.0/"
  export HADOOP_CONF_DIR="$HADOOP_HOME/etc/hadoop/"
  prefix_to_path "$HADOOP_HOME/bin"
  # How to config sdkman so this is at start of PATH?
  prefix_to_path '/Users/ashimghosh/.sdkman/candidates/java/8.0.382-zulu/bin'

  alias 'dnew_spark_proj=sbt new sarkutz/spark-scala.g8'

  function start_cluster() {
      sbin="$DOTFILES_SOFTWARE_STANDALONE/hadoop-3.3.0/sbin"
      $sbin/start-dfs.sh
      $sbin/start-yarn.sh

      echo 'NameNode: http://localhost:9870/'
      echo 'ResourceManager: http://localhost:8088/'
  }
  function stop_cluster() {
      sbin="$DOTFILES_SOFTWARE_STANDALONE/hadoop-3.3.0/sbin"
      $sbin/stop-yarn.sh
      $sbin/stop-dfs.sh
  }

  function deact_scala_alias_space() {
    remove_from_alias_space_variable scala

    remove_from_path "$HADOOP_HOME/bin"
    export HADOOP_HOME=
    export HADOOP_CONF_DIR=

    unalias dnew_spark_proj

    unset -f start_cluster
    unset -f stop_cluster

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

  function goplay() {
      usage='goplay: Open Go in Docker for quick experiments
USAGE: goplay'

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

  # jspp: JS Pretty Print (JS Beautifier)
  alias jspp='python $DOTFILES_SOFTWARE_INSTALL_PREFIX/bin/jsbeautify.py'

  function jsplay() {
      usage='jsplay: Open JS in Docker for quick experiments.
USAGE: jsplay'

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

    unalias jspp
    unset -f jsplay

    unset -f deact_js_alias_space
  }
}

