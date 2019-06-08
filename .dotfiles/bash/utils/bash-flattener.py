#!/usr/bin/env python

import sys
import re
import os
from datetime import datetime


g_pat_source_cmd = r'\s*source\s+"?\$\{DOTFILES\}/([^"]+)"?'
g_dotfile = 'DOTFILES'


def read_file(filepath, mode):
    with open(filepath, mode) as f:
        content = f.read()
    return content
    

def read_input_script():
    """Read input from file (if specified), else read from stdin

    :returns: (filename, file_content)
    """
    if len(sys.argv) > 1:
        content = read_file(sys.argv[1], 'r')
        return sys.argv[1], content

    return 'stdin', sys.stdin.read()


def write_output_script(out_script):
    """Write output output file (if specified) else write to stdout

    :out_script: string to write to file

    :returns: None
    """
    if len(sys.argv) > 2:
        with open(sys.argv[2], 'w') as f:
            f.write(out_script)
    else:
        sys.stdout.write(out_script)


def get_sourced_filename(line, regex_source_cmd):
    """Return filename if line is a source command, else return None

    :line: String to match for source command
    :regex_source_cmd: Regex object for source command

    :returns: Filename if line is a source command, else return None
    """
    match = regex_source_cmd.search(line)
    return match.group(1) if match else None


def flatten_file(file_content, regex_source_cmd, file_inclusion_chain):
    """Given file data, ``flatten_file`` with replace all ``source``
    statements with the file_content of the "sourced" file.

    :file_content: file file_content to flatten
    :regex_source_cmd: Compiled regex object to match the source statement
    :file_inclusion_chain: List of file inclusions that cause this file to
        be included

    :returns: String containing flattened file file_content
    """
    if 100 < len(file_inclusion_chain):
        print("ERROR: File inclusion depth exceeded limit (100).  "
                "Please check for cyclic dependencies in the following file"
                "inclusion chain: {0}".format(file_inclusion_chain))
        return file_content

    path_dotfiles = os.environ['DOTFILES']

    for line in file_content.split('\n'):
        sourced_filename = get_sourced_filename(line, regex_source_cmd)
        if not sourced_filename:
            continue

        file_inclusion_chain.append(sourced_filename)

        sourced_filepath = os.path.join(path_dotfiles, sourced_filename)
        sourced_file_content = read_file(sourced_filepath, 'r')

        sourced_file_content = flatten_file(sourced_file_content,
                regex_source_cmd, file_inclusion_chain)

        file_content = file_content.replace(line, sourced_file_content)

    return file_content


def print_usage():
    print("Usage: {0} [in.sh] [out.sh]".format(sys.argv[0]))


def main():
    if len(sys.argv) > 3:
        print_usage()
        return

    file_name, file_content = read_input_script()

    regex_source_cmd = re.compile(g_pat_source_cmd)
    out_script = flatten_file(file_content, regex_source_cmd, [file_name])

    header = "### Generated by {name} on {today}.\n\n".format(
        name=os.path.basename(sys.argv[0]),
        today=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
    )
    write_output_script(header + out_script)


if __name__ == '__main__':
    main()
