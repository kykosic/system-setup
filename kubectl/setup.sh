#!/bin/bash
set -e

cwd=$(pwd)
cd "$HOME"

echo "Installing kubectl"
if [[ "$OSTYPE" == "darwin"* ]]; then
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl"
else
    curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
fi
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

cd "$cwd"
kubectl version --client