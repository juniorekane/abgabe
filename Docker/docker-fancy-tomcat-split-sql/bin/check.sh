#!/usr/bin/env bash
echo "in der Maschine selbst auf Port 80:"
curl -s http://localhost | html2text

work_ip=$(docker exec work hostname -I)
echo "IP von work im docker-Netzwerk ist $work_ip"
machine_ip=$(hostname -I | cut -d' ' -f1)
echo "Die IP Deiner Umgebung ist $machine_ip"
echo "Versuche es im Browser unter http://$machine_ip/"

echo "ssh in den Container work als User user:"
ssh work 'echo "User $(whoami) auf $(hostname -I|cut -d" " -f1) ($(hostname))"'

ssh work sudo -l
ssh work ssh services sudo -l

ssh work "mariadb -e 'select count(*) from demo'"

ssh work "ssh services redis-cli set x 1"

ssh  work "cd javawebdemo; bin/build.sh 2>/dev/null"
ssh work curl -s http://services:8080/hello 


