#!/usr/bin/env bash
source local/config.txt || exit 1

JAVAFILES=$(find src -name '*.java')
echo "COMPILE: $(echo $JAVAFILES|wc -w)"
javac -Xlint:unchecked -cp 'lib/*' -d build/WEB-INF/classes $JAVAFILES &&
	echo "COMPILE:  success" || { echo "COMPILE:  failure"; exit 1;}
libs=$(ls lib/*jar|tr '\n' ':')
java -cp 'build/WEB-INF/classes:'$libs hbv.service.App

