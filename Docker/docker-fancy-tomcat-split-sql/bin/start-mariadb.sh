#!/usr/bin/env bash
LC_ALL=C
. local/config.txt

imagename=image-fancy
containername=services-mariadb

bin/shutdown.sh "$containername"

# touch log file
mkdir -p www log
touch log/docker.log
echo -n > log/state-services-mariadb.txt

docker container create \
	--name "$containername" \
	--hostname "$containername" \
	--network mynet \
	--volume "$PWD/www/:/var/www/html" \
	--volume "$PWD/log/:/log" \
	--publish 30:30 \
	--publish 8030:8030 \
	--publish 3706:3706 \
	"$imagename"

# copy startup files to /usr/bin
docker container cp context/myinit-$containername.sh "$containername:/usr/bin/myinit.sh"
docker container cp context/startup "$containername:/"
docker container cp local/config.txt "$containername:/startup"

# start container
docker container start "$containername"

# exit if start failed
if test "$?" != "0"; then
	echo "failed to start with exit-code: $?" >&2
	exit 1
fi

# wait for state == ready
while test ready != "$(cat log/state-services-mariadb.txt)"; do
  echo wait for state = ready
  sleep 1
done

