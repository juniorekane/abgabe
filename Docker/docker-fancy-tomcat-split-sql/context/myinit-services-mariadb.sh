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

    read -r mariadbpid </var/run/mysqld/mysqld.pid
    read -r sshdpid </var/run/sshd.pid
    service ssh stop
    rm /var/run/mysqld/mysqld.pid
    service mariadb stop
    echo "$sshdpid,$mariadbpid" >>$log
    while ps -p "$sshdpid,$mariadbpid" >/dev/null; do
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
  usermod -aG tomcat user
  pw=$(grep "^containerpassword=" /startup/config.txt|cut -d'=' -f2)

  # configure mariadb
  cp /startup/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
  

  service ssh start
  a2enmod cgi
  chown user:user /usr/lib/cgi-bin/
  service mariadb start

  /startup/create-db.sh
  #rm /startup/*
  echo ready > /log/state-services-mariadb.txt
} >>$log

while true; do
  echo "$(date +%FT%T) ping" >>$log
  read -r -t 60 </dev/fd/1
done
