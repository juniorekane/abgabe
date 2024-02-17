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
    read -r tomcatpid </opt/tomcat/tomcat.pid
    service ssh stop
    rm /var/run/mysqld/mysqld.pid
    sudo -u tomcat CATALINA_PID=/opt/tomcat/tomcat.pid /opt/tomcat/bin/shutdown.sh
    echo "$sshdpid,$tomcatpid" >>$log
    while ps -p "$sshdpid,$tomcatpid" >/dev/null; do
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
  # configure tomcat
  sed -i 's:^.*allow=.*$:   allow="^.*$"/>:g' /opt/tomcat/webapps/manager/META-INF/context.xml   
  sudo -u tomcat cp /startup/tomcat-users.xml /opt/tomcat/conf
  sudo -u tomcat cp /startup/server.xml /opt/tomcat/conf
  sed -i "s/thetomcatmanagerpassword/$pw/g" /opt/tomcat/conf/tomcat-users.xml
  echo 'user ALL = (tomcat:tomcat) NOPASSWD:ALL' >> /etc/sudoers.d/100_generic
  echo 'user ALL = (ALL) NOPASSWD:ALL' >> /etc/sudoers.d/tcpdump


  service ssh start
  a2enmod cgi
  chown user:user /usr/lib/cgi-bin/

  # start tomcat
  mkdir -p /data/upload/
  chown -R tomcat:tomcat /data/
  sudo -u tomcat CATALINA_PID=/opt/tomcat/tomcat.pid /opt/tomcat/bin/startup.sh
  #rm /startup/*
  echo ready > /log/state-services-tomcat.txt
} >>$log

while true; do
  echo "$(date +%FT%T) ping" >>$log
  read -r -t 60 </dev/fd/1
done
