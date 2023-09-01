#!/usr/bin/env bash

# bash-powerline.sh
#
# Modified version of https://github.com/riobard/bash-powerline

## Uncomment to disable git info
#POWERLINE_GIT=0

__powerline() {
    # Colorscheme
    readonly RESET='\[\033[m\]'
    readonly COLOR_CWD='\[\033[0;34m\]' # blue
    readonly COLOR_GIT='\[\033[0;36m\]' # cyan
    readonly COLOR_SUCCESS='\[\033[0;32m\]' # green
    readonly COLOR_FAILURE='\[\033[0;31m\]' # red

    readonly SYMBOL_GIT_BRANCH='⑂'
    readonly SYMBOL_GIT_MODIFIED='*'
    readonly SYMBOL_GIT_PUSH='↑'
    readonly SYMBOL_GIT_PULL='↓'

    __python_info() {
        nbr_py_files="$( find . -maxdepth 1 -name '*.py' | wc -l )"
        if [[ $nbr_py_files -ne 0 ]]; then
            env_name="$( basename $( dirname $(dirname $( which python3 ) ) ) )"
        else
            env_name=
        fi
        printf "$env_name"
    }

    __conda_info() {
        echo $PATH | grep conda &> /dev/null
        [[ $? -eq 0 ]] && printf "conda"
    }

    __vi_swp_info() {
        n_vi="$( find . -maxdepth 1 -name '*.sw?' | wc -l )"
        if [[ $n_vi -gt 0 ]]; then
            printf "${COLOR_FAILURE}vi${RESET}"
        fi
    }

    __git_info() {
        [[ $POWERLINE_GIT = 0 ]] && return # disabled
        hash git 2>/dev/null || return # git not found
        local git_eng="env LANG=C git"   # force git output in English to make our work easier

        # get current branch name
        local ref=$($git_eng symbolic-ref --short HEAD 2>/dev/null)

        if [[ -n "$ref" ]]; then
            # prepend branch symbol
            ref=$SYMBOL_GIT_BRANCH$ref
        else
            # get tag name or short unique hash
            ref=$($git_eng describe --tags --always 2>/dev/null)
        fi

        [[ -n "$ref" ]] || return  # not a git repo

        local marks

        # scan first two lines of output from `git status`
        while IFS= read -r line; do
            if [[ $line =~ ^## ]]; then # header line
                [[ $line =~ ahead\ ([0-9]+) ]] && marks+=" $SYMBOL_GIT_PUSH${BASH_REMATCH[1]}"
                [[ $line =~ behind\ ([0-9]+) ]] && marks+=" $SYMBOL_GIT_PULL${BASH_REMATCH[1]}"
            else # branch is modified if output contains more lines after the header line
                marks="$SYMBOL_GIT_MODIFIED$marks"
                break
            fi
        done < <($git_eng status --porcelain --branch 2>/dev/null)  # note the space between the two <

        # print the git branch segment without a trailing newline
        printf " $ref$marks"
    }

    __ranger_info() {
        # ps -fp $PPID | grep -q ranger && printf "ranger" || printf ""
        ps -fp $PPID | grep -q ranger && printf "ranger"
    }

    if [[ -z "$PS_SYMBOL" ]]; then
      case "$(uname)" in
          Darwin)   PS_SYMBOL='';;
          Linux)    PS_SYMBOL='$';;
          *)        PS_SYMBOL='%';;
      esac
    fi

    ps1() {
        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly. 
        if [ $? -eq 0 ]; then
            local symbol=" $COLOR_SUCCESS$PS_SYMBOL $RESET"
        else
            local symbol=" $COLOR_FAILURE$PS_SYMBOL $RESET"
        fi

	local alias_spaces=
	[[ -n $DOTFILES_ALIAS_SPACES ]] && alias_spaces=" $COLOR_GIT$DOTFILES_ALIAS_SPACES$RESET"

        local pyenvs="$(__python_info)"
        [[ -n $pyenvs ]] && pyenvs=" ($COLOR_GIT$pyenvs$RESET)"

        local pyconda="$(__conda_info)"
        [[ -n $pyconda ]] && pyconda=" ($COLOR_GIT$pyconda$RESET)"

        local system_details="\u@\h:\W"
        [[ -n $system_details ]] && system_details=" $COLOR_CWD$system_details$RESET"

        # Bash by default expands the content of PS1 unless promptvars is disabled.
        # We must use another layer of reference to prevent expanding any user
        # provided strings, which would cause security issues.
        # POC: https://github.com/njhartwell/pw3nage
        # Related fix in git-bash: https://github.com/git/git/blob/9d77b0405ce6b471cb5ce3a904368fc25e55643d/contrib/completion/git-prompt.sh#L324
        if shopt -q promptvars; then
            __powerline_git_info="$(__git_info)"
            local git="${__powerline_git_info}"
        else
            # promptvars is disabled. Avoid creating unnecessary env var.
            local git="$(__git_info)"
        fi
	[[ -n $git ]] && git=" $COLOR_GIT$git$RESET"

        local vi="$(__vi_swp_info)"
	[[ -n $vi ]] && vi=" $vi"

        local ranger="$(__ranger_info)"
        [[ -n $ranger ]] && ranger=" $ranger"

        PS1="$alias_spaces$pyconda$pyenvs$system_details$git$vi$ranger$symbol"
    }

    PROMPT_COMMAND="ps1${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
}

__powerline
unset __powerline
