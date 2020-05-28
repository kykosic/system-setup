#!/bin/bash
set -e

cwd=$(pwd)
cd "$HOME"

echo "Installing kubectl"
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl"
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

cd "$cwd"
kubectl version --client