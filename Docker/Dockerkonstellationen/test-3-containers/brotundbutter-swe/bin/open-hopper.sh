#!/usr/bin/env bash
source local/config.txt || exit 1
codium --folder-uri vscode-remote://ssh-remote+hopper/home/$user/repos/brotundbutter-swe
