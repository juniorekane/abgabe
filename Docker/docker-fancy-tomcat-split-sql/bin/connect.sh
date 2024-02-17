#!/usr/bin/env bash

ssh work cat .ssh/id_rsa.pub | docker exec -i --user user services  tee -a /home/user/.ssh/authorized_keys &>/dev/null
ssh work 'ssh-keygen -q -R services; ssh-keyscan services>> .ssh/known_hosts' &>/dev/null

ssh work cat .ssh/id_rsa.pub | docker exec -i --user user services-redis  tee -a /home/user/.ssh/authorized_keys &>/dev/null
ssh work 'ssh-keygen -q -R services-redis; ssh-keyscan services-redis>> .ssh/known_hosts' &>/dev/null

ssh work cat .ssh/id_rsa.pub | docker exec -i --user user services-mariadb  tee -a /home/user/.ssh/authorized_keys &>/dev/null
ssh work 'ssh-keygen -q -R services-mariadb; ssh-keyscan services-mariadb>> .ssh/known_hosts' &>/dev/null

ssh work cat .ssh/id_rsa.pub | docker exec -i --user user services-tomcat  tee -a /home/user/.ssh/authorized_keys &>/dev/null
ssh work 'ssh-keygen -q -R services-tomcat; ssh-keyscan services-tomcat>> .ssh/known_hosts' &>/dev/null
