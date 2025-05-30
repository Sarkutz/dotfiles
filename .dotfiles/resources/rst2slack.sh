#!/usr/bin/env bash

usage='rst2slack.sh
Convert ReStructuredText (rst) format to Slack Markdown format.
USAGE:
echo "Test :code:\`x=y\`" | rst2slack.sh
Provide the input text in stdin.  The output is printed to stdout and copied to
the system clipboard.'

shopt -s expand_aliases
source ~/.bashrc

cat - | pandoc -f rst -t gfm | pandoc -f gfm -t ${DOTFILES}/../resources/pandoc-md-to-slack/slack.lua | scc
spc

shopt -u expand_aliases
