#!/usr/bin/env bash
mkdir -p tmp
rm -f tmp/*

function doget { 
  local dst=$1; local version=$2; local fullpath="$3"; local overridename="$4"
  local name=$dst-$version.jar
  local realname=${overridename:=$name}
  local url="https://repo1.maven.org/maven2/$fullpath/$dst/$version/$dst-$version.jar"
  curl -f -s -o "$realname" "$url"
  echo "$realname $?"
}
cd tmp

doget jakarta.jakartaee-api 10.0.0    jakarta/platform
doget jedis                 5.1.0     redis/clients
doget json                  20231013  org/json
doget core                  3.5.2     com/google/zxing      zxing.3.5.2.core.jar
doget javase                3.5.2     com/google/zxing      zxing.3.5.2.javase.jar

rm  -f ../app/WEB-INF/lib/* ../lib/*
cp json-*.jar jedis-*.jar zxing*.jar ../app/WEB-INF/lib
cp json-*.jar jedis-*.jar zxing*.jar jakarta.jakartaee-api*jar ../lib
cd ..
rm -rf tmp
