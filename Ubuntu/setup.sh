#!/usr/bin/env bash
set -e

sudo apt-get update
sudo apt-get install --yes \
    zip \
    make \
    gcc \
    g++ \
    libssl-dev \
    pkg-config
