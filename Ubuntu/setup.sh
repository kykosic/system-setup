#!/usr/bin/env bash
set -e

echo 'Installing libs'
sudo apt-get update
sudo apt-get install --yes \
    zip \
    make \
    gcc \
    g++ \
    libssl-dev \
    pkg-config \
    apt-transport-https \
    ca-certificates \
    software-properties-common

echo 'Installing docker'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo usermod -aG docker $(whoami)

echo 'Docker installed, you may need to reboot now'
