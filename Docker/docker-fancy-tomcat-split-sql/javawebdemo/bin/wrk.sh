#!/usr/bin/env bash
source local/config.txt || exit 1
wrk -d 5 -c 400 -t 40 $baseurl/$webapp/hello
