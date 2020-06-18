#!/usr/bin/env bash
set -e

sudo chown -R $(whoami) /usr/local
sudo chown -R $(whoami) /opt

sudo apt-get update
sudo apt-get install --yes \
    zip
