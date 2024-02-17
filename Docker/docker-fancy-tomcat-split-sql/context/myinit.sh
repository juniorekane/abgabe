#!/bin/bash
log=/log/docker.log
echo "$(date +%FT%T) start" >>$log

trap onexit SIGTERM
trap onint SIGINT

function onint {
  echo "$(date +%FT%T) signal int" >>$log
  ps -ef >>$log
}

function onexit {
  # shutdown ...
  {
    echo "$(date +%FT%T) stop"
    ps -ef

    read -r sshdpid </var/run/sshd.pid
    service ssh stop
    echo "$sshdpid" >>$log
    while ps -p "$sshdpid" >/dev/null; do
      echo "$(date +%FT%T) waiting" >>$log
      sleep 0.1
    done
    ps -ef
  } >>$log
  exit
}

# start services
{
  /startup/create-user.sh
  pw=$(grep "^containerpassword=" /startup/config.txt|cut -d'=' -f2)
  service ssh start
  rm /startup/*
  echo ready >> /log/state-work.txt
} >>$log

while true; do
  echo "$(date +%FT%T) ping" >>$log
  read -r -t 60 </dev/fd/1
done
