#!/usr/bin/env bash
pw=$(grep "^containerpassword=" /startup/config.txt | cut -d'=' -f2)
mariadb -e 'create database dbdemo'
mariadb -e 'create user dbuser'
mariadb -e "grant all privileges on *.* to dbuser@'%' identified by '$pw'"
mariadb -e 'flush privileges'
mariadb -D dbdemo -e 'create table demo (id integer auto_increment primary key, name text)'
