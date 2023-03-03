#!/bin/bash

# STEP ONE: Create the instance
# instance type for tiny is "g6-standard-1" and for dedicated, "g6-dedicated-4",
# region for sydney is "ap-southeast"
curl -H "Content-Type: application/json" \
-H "Authorization: Bearer $TOKEN" \
-X POST -d '{
    "image": "linode/ubuntu18.04",
    "region": "ap-southeast",
    "type": $INSTANCETYPE,
    "label": "sydney-t1",
    "tags": [],
    "root_pass": $INSTANCE_PASSWORD,
    "authorized_users": [
        $USERS
    ],
    "booted": true,
    "backups_enabled": false,
    "private_ip": false
}' https://api.linode.com/v4/linode/instances

# STEP TWO: note down the IP, set up a subdomain on cloudflare, disable proxy, 

# STEP THREE: then do a lazy install
git clone https://github.com/pterodactyl-installer/pterodactyl-installer
cd pterodactyl-installer
./install.sh

# STEP FOUR: Obtain the auto-setup token from the panel and paste it in the CLI of the new node
