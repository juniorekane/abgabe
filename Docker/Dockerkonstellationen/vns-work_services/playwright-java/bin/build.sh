#!/usr/bin/env bash
rm -rf build && mkdir -p build
javac -g -d build -cp 'lib/*' src/hbv/**/*.java
java -cp build:"lib/*" hbv.playwright.Main
# mv videos/*.webm recording.webm

