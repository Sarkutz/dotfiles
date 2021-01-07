# bashrc-utils.sh
#
# *Contains utilities used by BASH config. files*.
#
# Usage: Source this file.

# Colors
# ======
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37
BASH_COLOR_RESET='\033[0m'
BASH_COLOR_RED='\033[0;31m'
BASH_COLOR_GREEN='\033[0;32m'
BASH_COLOR_ORANGE='\033[0;33m'
BASH_COLOR_BLUE='\033[0;34m'
BASH_COLOR_PURPLE='\033[0;35m'
BASH_COLOR_CYAN='\033[0;36m'
BASH_COLOR_GRAY='\033[0;37m'

BASH_COLOR_ERROR="${BASH_COLOR_RED}"
BASH_COLOR_SUCCESS="${BASH_COLOR_GREEN}"
BASH_COLOR_EM1="${BASH_COLOR_CYAN}"
BASH_COLOR_EM2="${BASH_COLOR_PURPLE}"


function prefix_unique() {
    text="$1"
    prefix="$2"
    delim="$3"

    usage='prefix_unique: Prefix to `text` only if `prefix` does not already exist in the string
USAGE: prefix_unique <text> <prefix> <delim>'
    if [[ $# -ne 3 ]]; then
        echo "$usage"
        return 1
    fi

    echo "$1" | grep -E "(^|${delim})${prefix}(${delim}|$)"
    if [[ $? -ne 0 ]]; then
        echo "${prefix}${delim}${text}"
    fi
}


function suffix_unique() {
    text="$1"
    suffix="$2"
    delim="$3"

    usage='suffix_unique: Suffix to `text` only if `suffix` does not already
    exist in the string
USAGE: suffix_unique <text> <suffix> <delim>'
    if [[ $# -ne 3 ]]; then
        echo "$usage"
        return 1
    fi

    echo "$1" | grep -E "(^|${delim})${suffix}(${delim}|$)"
    if [[ $? -ne 0 ]]; then
        echo "${text}${delim}${suffix}"
    fi
}


function prefix_to_path() {
  token="$1"

  usage='prefix_to_path: Add path as the first entry in PATH env. var.
NOTE: Updates the PATH env. var.
USAGE: prefix_to_path <path-to-prefix>'
  if [[ $# -ne 1 ]]; then
    echo "$usage"
    return 1
  fi

  export PATH="$( prefix_unique "$PATH" "$token" ':' )"
}


function remove_from_path() {
  token="$1"

  usage='remove_from_path: Remove a path from PATH env. var.
NOTE: Updates the PATH env. var.
USAGE: remove_from_path <path-to-remove>'
  if [[ $# -ne 1 ]]; then
    echo "$usage"
    return 1
  fi

  new_path="$( cd $DOTFILES/utils && \
      python -c "import bashrcutils; print(bashrcutils.remove_token('$PATH', '$token', ':'))")"
  [[ $? -ne 0 ]] && return 1

  export PATH="$new_path"
}


function get_num_lines() {
    usage='get_num_lines: Return the number of lines in the provided input
USAGE get_num_lines <text>'

    if [[ $# -ne 1 ]]; then
        echo "$usage"
        return 1
    fi
    msg="$1"

    if [[ -z "$msg" ]]; then
        num_lines=0
    else
        num_lines=$( echo "$msg" | wc -l )
    fi

    return $num_lines
}


function start_singleton() {
    proc=$1
    as_su=$2

    usage='start_singleton: Start the specified process only if it is not already running.
USAGE: start_singleton <proc> [as_su]'
    if [[ $# -ne 1 ]] && [[ $# -ne 2 ]]; then
        echo "$usage"
        return 1
    fi

    # Ensure idempotentance of process.
    nbr_proc=$( ps auxc | grep "$proc" - | wc -l )
    [[ $nbr_proc -ne 0 ]] && return 0

    if [[ -n $as_su ]]
    then 
        sudo "$proc" > /dev/null
    else
        "$proc" > /dev/null
    fi
}


function will_overwrite() {
    source_path="$1"
    dest_path="$2"

    usage='will_overwrite: Check if `source_path` might overwrite `dest_path`.
USAGE: will_overwrite <source_path> <dest_path>'
    if [[ $# -ne 2 ]]; then
        echo "$usage"
        return 1
    fi

    source_file=$( basename $source_path )

	if [[ -d "$dest_path" ]]
    then
		if [[ -a "$dest_path$source_file" ]] || [[ -a "$dest_path/$source_file" ]]
        then
				return 1
		fi

	elif [[ -a "$dest_path" ]]
    then
		return 1

	fi

    return 0
}


function rest() {
    api_id=$1
    http_method=$2
    uri_path="$3"
    post_data="$4"

    usage='rest: Make cURL calls to REST HTTP endpoints.
USAGE: rest <api-id> <http-method> <uri-path> [post-data]
where-
- `api-id`: Identifies the REST endpoint.  Values-
  - es: ElasticSearch on localhost
  - kib: Kibana on localhost
- `post_data` (optional): ASSUME: Post data is in JSON format.
EXAMPLE: rest es GET /_cat/indices?v'
    if [[ $# -ne 3 ]] && [[ $# -ne 4 ]]; then
        echo "$usage"
        return 1
    fi

    # Set endpoint chosen by endpoint_id
    if [[ $api_id == 'es' ]]; then
        endpoint='http://localhost:9200'
    elif [[ $api_id == 'kib' ]]; then
        endpoint='http://localhost:5601'
    else
        endpoint="$api_id"
    fi
    if [[ -z $endpoint ]]; then
        echo "Invalid endpoint: api_id=$api_id" >&2
        return 1
    fi

    # Get response from HTTP REST API
    response=
    if [[ -n "$post_data" ]]; then
        response="$( curl --silent -X$http_method "${endpoint}$uri_path" \
            -H "Content-Type: application/json" --data-binary "$post_data" )"
    else
        response="$( curl --silent -X$http_method "${endpoint}$uri_path" )"
    fi

    # Try to parse response as JSON; else dump response as-is
    echo "$response" | jq '.' 2> /dev/null
    if [[ $? -ne 0 ]]; then
        echo "$response"
    fi
}
complete -W "es kib" rest


function find_and_jump() {
    usage='find_and_jump: Find path matching search_term under find_root,
and jump to it if single matching path is found.
USAGE: find_and_jump <find_root> <search_term>
First find for path that matches ``search_term`` exactly.
- If a single path is found then jump to it.
- If multiple paths are found then print all paths and return with return value 2.
- If no path is found then repeat this process with a substring match (``*search_term*``).'
    if [[ $# -ne 2 ]]; then
        echo "Insufficient parameters" >&2
        echo "$usage" >&2
        return 1
    fi
    find_root="$1"
    search_term="$2"

    # Exact match
    find_exact_output="$( find $find_root -type d -name "$search_term" )"
    echo "$find_exact_output"
    get_num_lines "$find_exact_output"
    n_lines_find_output="$?"
    [[ $n_lines_find_output -eq 1 ]] && cd "$find_exact_output" && ls -GCF && return 0

    if [[ $n_lines_find_output -eq 0 ]]; then
        # Substring match
        find_output="$( find $find_root -type d -name '*'"$search_term"'*' )"
        echo "$find_output"
        get_num_lines "$find_output"
        [[ $? -eq 1 ]] && cd "$find_output" && ls -GCF && return 0
    fi
}

