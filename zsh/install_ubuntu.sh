#!/usr/bin/env bash
set -e

# Installing zsh
echo 'Installing zsh'
sudo apt-get update
sudo apt-get install -y zsh
sudo usermod -s /usr/bin/zsh $(whoami)
