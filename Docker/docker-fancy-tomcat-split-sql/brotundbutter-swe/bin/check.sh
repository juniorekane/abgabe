#!/usr/bin/env bash
source local/config.txt || exit 1
path="$baseurl/$webapp"
curl -s "$path/assembled.txt"
curl -s "$path/hello"
curl -s "$path/redis"
curl -s "$path/sql"
curl -s "$path/json"
curl -s "$path/createimage" |  identify -format "%m %B %z %r %A %wx%h\n" -

id=$(curl -s -F name=filename -F thefile=@misc/small.png $baseurl/uploadimage|cut -d ' ' -f2)
curl -s "$path/getimage?id=$id" | identify  -format "%m %B %z %r %A %wx%h\n" -

mkdir -p tmp
curl -L -c tmp/cookie-$$.jar -b tmp/cookie-$$.jar $path/login?"user=demo&passwd=pwd"
curl -L -c tmp/cookie-$$.jar -b tmp/cookie-$$.jar $path/protected
curl -L -c tmp/cookie-$$.jar -b tmp/cookie-$$.jar $path/logout
curl -L -c tmp/cookie-$$.jar -b tmp/cookie-$$.jar $path/protected
rm tmp/cookie-$$.jar
