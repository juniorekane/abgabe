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

    read -r redispid </var/run/redis/redis-server.pid
    read -r sshdpid </var/run/sshd.pid
    service ssh stop
    kill "$redispid"
    echo "$redispid,$sshpid" >>$log

   while ps -p "$redispid,$sshdpid" >/dev/null; do
     echo "$(date +FT%T) waiting" >> $log
     sleep 0.1
   done
   ps -ef
 } >>$log
 exit
}

#start redis
{
  #configure redis
  mkdir /var/run/redis
  chown redis /var/run/redis
  sed -i "s/^[ #]*requirepass .*/requirepass $pw/g" /etc/redis/redis.conf
  sed -i "s/^bind 127\.0\.0\.1.*/bind 0.0.0.0/g" /etc/redis/redis.conf

  sudo -u redis redis-server /etc/redis/redis.conf

  /startup/create-user.sh
  pw=$(grep "^containerpassword=" /startup/config.txt|cut -d'=' -f2)
  service ssh start
  a2enmod cgi
  chown user:user /usr/lib/cgi-bin/
  echo 'user ALL = (ALL) NOPASSWD:ALL' >> /etc/sudoers.d/sshd

  #rm /startup*
  echo ready > /log/state-redis.txt
} >>$log

while true; do
  echo "$(date +FT%T)) ping" >> $log
  read -t -r 60 < /dev/fd/1
done

