#!/usr/bin/env bash

ssh work cat .ssh/id_rsa.pub | docker exec -i --user user services  tee -a /home/user/.ssh/authorized_keys &>/dev/null
ssh work 'ssh-keygen -q -R services; ssh-keyscan services>> .ssh/known_hosts' &>/dev/null
ssh work cat .ssh/id_rsa.pub | docker exec -i --user user tomcat  tee -a /home/user/.ssh/authorized_keys &>/dev/null
ssh work 'ssh-keygen -q -R tomcat; ssh-keyscan tomcat>> .ssh/known_hosts' &>/dev/null
