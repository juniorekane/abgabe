#!/usr/bin/env bash
cd context || exit 1
mkdir -p opt
rm -rf opt/*tomcat*
cd opt

tomcatversion=$(curl -s https://dlcdn.apache.org/tomcat/tomcat-10/ | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | head -n1 | cut -c'2-')
wget -q https://dlcdn.apache.org/tomcat/tomcat-10/v$tomcatversion/bin/apache-tomcat-$tomcatversion.tar.gz
tar -xzf apache-tomcat-$tomcatversion.tar.gz
rm apache-tomcat-$tomcatversion.tar.gz
mv apache-tomcat-$tomcatversion tomcat

