#!/bin/bash

# Update

apt-get update

apt-get -y upgrade

# UFW

ufw allow ssh comment ssh

ufw enable

ufw allow 8080 comment "Pterodactyl Daemon"

ufw allow 2022 comment "Pterodactyl SFTP"

ufw allow 80 comment "Standalone Webserver For SSL (Using Certbot)"

# Certbot

apt-get -y install certbot

# other dependencies

apt-get -y install unzip tar python

# Docker

curl -sSL https://get.docker.com/ | CHANNEL=stable bash

systemctl enable docker

# Nodejs

curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -

apt -y install nodejs make gcc g++

# Pterodactyl Daemon

mkdir -p /srv/daemon /srv/daemon-data

cd /srv/daemon

curl -L https://github.com/pterodactyl/daemon/releases/download/v0.6.12/daemon.tar.gz | tar --strip-components=1 -xzv

npm install --only=production

npm audit fix

# Daemon Service

echo "[Unit]

Description=Pterodactyl Wings Daemon

After=docker.service

[Service]

User=root

#Group=some_group

WorkingDirectory=/srv/daemon

LimitNOFILE=4096

PIDFile=/var/run/wings/daemon.pid

ExecStart=/usr/bin/node /srv/daemon/src/index.js

Restart=on-failure

StartLimitInterval=600

[Install]

WantedBy=multi-user.target" > /etc/systemd/system/wings.service