#!/usr/bin/env bash
vmstat 1|grep --line-buffer "^[0-9 ]*$" | stdbuf -oL tr -s ' ' |stdbuf -oL cut -d' ' -f 16 | while read line; do echo "$((100-line))"; done
