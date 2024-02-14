#!/usr/bin/env bash
LC_ALL=C
. local/config.txt

imagename=image-fancy
containername=work

bin/shutdown.sh "$containername"

# touch log file
mkdir -p www log
touch log/docker.log
echo -n > log/state-work.txt

# create container on network mynet with extra volume publish port 80
docker container create \
	--name "$containername" \
	--hostname "$containername" \
	--network mynet \
	--volume "$PWD/log/:/log" \
	--volume "$PWD/www/:/var/www/html" \
  --add-host host.docker.internal:host-gateway \
	"$imagename"

# copy startup file to /usr/bin
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

while test ready != "$(cat log/state-work.txt)"; do
  echo wait for state = ready
  sleep 1
done

# inject public key
docker container exec -i "$containername" tee -a /home/user/.ssh/authorized_keys <~/.ssh/id_rsa.pub >/dev/null

# append to /etc/bash.bashrc
docker container exec -i "$containername" tee -a /etc/bash.bashrc < context/bash.bashrc.append > /dev/null


# get ip from container
ip=$(docker container inspect "$containername" | jq -r ".[0].NetworkSettings.Networks.mynet.IPAddress")
echo "ip:$ip"

# remove previous keys for container
ssh-keygen -q -R "$ip" &>/dev/null

# get host keys from container
ssh-keyscan "$ip" >>~/.ssh/known_hosts 2>/dev/null

if ! test -f ~/.ssh/docker_config || ! grep -q "^ *[iI]nclude ~/.ssh/docker_config" ~/.ssh/config; then
	echo "fix ~/.ssh/config and ~/.ssh/docker_config" >&2
	exit 2
fi

# remove host name -> ip from ~/.ssh/docker_config
sed -i -e "/host ${containername} .*$/,/^$/D" ~/.ssh/docker_config

# add host name -> ip to ssh config
echo "host ${containername} # auto
  hostname ${ip}
  user user
" >>~/.ssh/docker_config

ssh $containername :
scp -qr javawebdemo $containername:
scp -qr brotundbutter-swe $containername:
scp -qr unittester $containername:

ssh $containername "sed -i 's/localhost/services/g'  javawebdemo/local/config.txt"
if test -e ~/key-of-outer-host.pub; then
  echo "inject outer host key"
  ssh work "cat >> .ssh/authorized_keys" < ~/key-of-outer-host.pub
fi
