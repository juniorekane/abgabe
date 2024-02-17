#!/usr/bin/env bash

architecture=$(uname -m)
mkdir -p download
cd download/
test "$architecture" = x86_64 && arch=amd64
test "$architecture" = aarch64 && arch=arm64
baseurl="https://informatik.hs-bremerhaven.de/hlipskoch/tester-unit-testing"
if curl -f -s -o /dev/null "$baseurl/latest_$arch" ; then
  list=$(curl -s  $baseurl/latest_$arch)
  for i in $list; do curl -s -O "$baseurl/$i"; done
fi
sudo dpkg -i *.deb 

