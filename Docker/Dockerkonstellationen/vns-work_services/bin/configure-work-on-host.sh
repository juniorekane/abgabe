#!/usr/bin/env bash
# copy this into outer host on macos and windows
# add 'Include ~/.ssh/docker_config' at the top
# of ~/.ssh/config
ip=$(ssh ubuntu "docker container inspect work|jq -r '.[0].NetworkSettings.Networks.mynet.IPAddress'")
echo "work has ip: [$ip]"
# shellcheck disable=SC2029
ssh-keygen -q -R "$ip" && ssh ubuntu ssh-keyscan "$ip" >>~/.ssh/known_hosts
ssh ubuntu "docker exec -i --user user work tee -a /home/user/.ssh/authorized_keys" < ~/.ssh/id_ed25519.pub
name=work
touch ~/.ssh/docker_config
sed -i -e "/host $name/,/^$/D" ~/.ssh/docker_config
if test "$ip" != ""; then
	echo "host ${name} # auto
  hostname ${ip}
  user user
  proxyjump ubuntu
  " >>~/.ssh/docker_config
fi
