#!/bin/bash
useradd -m -s /bin/bash user
pw=$(grep "^containerpassword=" /startup/config.txt | cut -d'=' -f2)

echo "user:$pw"| chpasswd
sudo -u user ssh-keygen -q -N '' -f /home/user/.ssh/id_rsa
sudo -u user touch /home/user/.hushlogin
sudo -u user touch /home/user/.ssh/authorized_keys
chmod go-rwx /home/user/.ssh/authorized_keys
echo 'user ALL = (ALL:ALL) NOPASSWD:/usr/bin/apt
user ALL = (ALL:ALL) NOPASSWD:/usr/bin/dpkg
' >> /etc/sudoers.d/100_generic

sudo -u user mkdir /home/user/.npm-packages
sudo -u user npm config set prefix /home/user/.npm-packages

echo 'NPM_PACKAGES="/home/user/.npm-packages"
export PATH=$PATH:$NPM_PACKAGES/bin' >> /home/user/.bashrc

# fancy Prompt with whale into .bashrc
printf "%s" "PS1='🐳  \[\e[32m\]\u@\h\[\e[00m\]:\[\e[32m\]\w \[\e[00m\]$ '" >> /home/user/.bashrc
cp /startup/.vimrc /home/user/
echo "[client]
user=dbuser
password=$pw
host=services

[mysql]
database=dbdemo" > /home/user/.my.cnf
chown user:user /home/user/{.my.cnf,.vimrc}
chmod go-rwx /home/user/.my.cnf
