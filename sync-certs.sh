#!/usr/bin/env bash
# copy certs from bastion to local to host

# exit if a command fails
set -o errexit

# exit if required variables aren't set
set -o nounset

if [[ "$EUID" -ne 0 ]]; then
  echo "Please run as root"
  exit
fi

bastion="bastion.galenguyer.com"
host="k8s-galenguyer-01.eastus.cloudapp.azure.com"

eval `ssh-agent`
ssh-add ~/.ssh/id_rsa

# copy from bastion to tmp
rsync -avz --delete -e "ssh" --rsync-path="sudo rsync" chef@"$bastion":/root/.acme.sh/antifausa.net/ /etc/ssl/antifausa.net/
rsync -avz --delete -e "ssh" --rsync-path="sudo rsync" chef@"$bastion":/root/.acme.sh/galenguyer.com/ /etc/ssl/galenguyer.com/

# copy from tmp to host
ssh chef@"$host" sudo mkdir -p /etc/ssl/{antifausa.net,galenguyer.com}
rsync -avz -e "ssh" --rsync-path="sudo rsync" /etc/ssl/antifausa.net/ chef@"$host":/etc/ssl/antifausa.net/
rsync -avz -e "ssh" --rsync-path="sudo rsync" /etc/ssl/galenguyer.com/ chef@"$host":/etc/ssl/galenguyer.com/
