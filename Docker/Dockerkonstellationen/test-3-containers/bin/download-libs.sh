#!/usr/bin/env bash
mkdir -p tmp

function doget { 
  dst=$1; version=$2; url="$3"
  mkdir -p tmp/$1
  wget -q -nc -P "tmp/$dst" "$url"
}

dst=mariadb-java-client; version=3.3.1
doget $dst $version https://repo1.maven.org/maven2/org/mariadb/jdbc/$dst/$version/$dst-$version.jar
cp tmp/$dst/*jar context/opt/tomcat/lib/
