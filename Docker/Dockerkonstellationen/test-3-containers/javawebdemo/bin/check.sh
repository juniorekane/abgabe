#!/usr/bin/env bash
source local/config.txt || exit 1
curl $baseurl/$webapp/hello
