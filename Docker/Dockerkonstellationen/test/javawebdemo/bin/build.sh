#!/usr/bin/env bash

source local/config.txt || exit 1

# prepare
mkdir -p build target
cp -r app/* build

# compile
JAVAFILES=$(find src -name '*.java')
javac -cp 'lib/*' -d build/WEB-INF/classes $JAVAFILES && echo compile success

# assemble
jar -cf "target/webapp.war" -C build . && echo build webapp.war

# deploy
curl --silent --location --netrc-file local/netrc --fail \
  --upload-file "target/webapp.war" \
  "$baseurl/$manager/text/deploy?path=/$webapp&update=true" || echo "deploy failed"

# check
curl "$baseurl/$webapp/hello"
