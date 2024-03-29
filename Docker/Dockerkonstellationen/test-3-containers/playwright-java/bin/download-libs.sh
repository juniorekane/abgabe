#!/usr/bin/env bash

mvn=https://repo1.maven.org/maven2

cd lib

dst=gson
version=2.10.1
curl -sO "$mvn/com/google/code/$dst/$dst/$version/$dst-$version.jar"

version=1.40.0
for lib in playwright driver driver-bundle; do
  base=$mvn/com/microsoft/playwright
  curl -sO "$base/$lib/$version/$lib-$version.jar"
done

