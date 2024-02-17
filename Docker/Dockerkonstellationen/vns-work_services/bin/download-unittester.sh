#!/usr/bin/env bash
abs=$PWD
mkdir -p $abs/context/opt/download/{arm64,amd64}
for arch in arm64 amd64; do
  cd $abs/context/opt/download/$arch || exit 1
  baseurl="https://informatik.hs-bremerhaven.de/hlipskoch/tester-unit-testing"
  if curl -f -s -o /dev/null "$baseurl/latest_$arch" ; then
    list=$(curl -s  $baseurl/latest_$arch)
    for i in $list; do
      # echo "download $baseurl$i"
      curl -s -O "$baseurl/$i"
    done
  fi
done
