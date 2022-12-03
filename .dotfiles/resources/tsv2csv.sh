#!/bin/sh

cat "/dev/stdin" | sed 's/^/"/' | sed 's/$/"/' | sed -E 's/	/","/g'

