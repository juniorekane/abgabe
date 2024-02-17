#!/bin/bash
containername="$1"
if docker container ls | grep -q "\b${containername}$"; then
	docker container stop $containername
fi

if docker container ls --all | grep -q "\b${containername}$"; then
	docker container rm $containername	
fi
sed -i -e "/host ${containername} .*$/,/^$/D" ~/.ssh/docker_config
