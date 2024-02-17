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

    read -r apachepid </run/apache2/apache2.pid
    read -r redispid </var/run/redis/redis-server.pid
    read -r mariadbpid </var/run/mysqld/mysqld.pid
    read -r sshdpid </var/run/sshd.pid
    read -r tomcatpid </opt/tomcat/tomcat.pid
    service ssh stop
    #apachectl stop
    rm /var/run/mysqld/mysqld.pid
    service mariadb stop
    #kill "$redispid"
    #sudo -u tomcat CATALINA_PID=/opt/tomcat/tomcat.pid /opt/tomcat/bin/shutdown.sh
    echo "$sshdpid,$apachepid,$redispid,$mariadbpid,$tomcatpid" >>$log
    while ps -p "$sshdpid,$apachepid,$redispid,$mariadbpid,$tomcatpid" >/dev/null; do
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
  #usermod -aG tomcat user
  pw=$(grep "^containerpassword=" /startup/config.txt|cut -d'=' -f2)
  # configure tomcat
  #sed -i 's:^.*allow=.*$:   allow="^.*$"/>:g' /opt/tomcat/webapps/manager/META-INF/context.xml   
  #sudo -u tomcat cp /startup/tomcat-users.xml /opt/tomcat/conf
  #sudo -u tomcat cp /startup/server.xml /opt/tomcat/conf
  #sed -i "s/thetomcatmanagerpassword/$pw/g" /opt/tomcat/conf/tomcat-users.xml
  #echo 'user ALL = (tomcat:tomcat) NOPASSWD:ALL' >> /etc/sudoers.d/100_generic
  #echo 'user ALL = (ALL) NOPASSWD:ALL' >> /etc/sudoers.d/tcpdump

  # configure mariadb
  cp /startup/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

  # configure redis
  #mkdir /var/run/redis
  #chown redis /var/run/redis
  #sed -i "s/^[ #]*requirepass .*/requirepass $pw/g" /etc/redis/redis.conf
  #sed -i "s/^bind 127\.0\.0\.1.*/bind 0.0.0.0/g" /etc/redis/redis.conf

  #sudo -u redis redis-server /etc/redis/redis.conf
  

  service ssh start
  a2enmod cgi
  chown user:user /usr/lib/cgi-bin/
  #apachectl start
  service mariadb start

  /startup/create-db.sh
  # start tomcat
  #mkdir -p /data/upload/
  #chown -R tomcat:tomcat /data/
  #sudo -u tomcat CATALINA_PID=/opt/tomcat/tomcat.pid /opt/tomcat/bin/startup.sh
  #rm /startup/*
  echo ready > /log/state-mariadb.txt
} >>$log

while true; do
  echo "$(date +%FT%T) ping" >>$log
  read -r -t 60 </dev/fd/1
done
