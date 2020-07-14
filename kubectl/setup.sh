#!/bin/bash
set -e

cwd=$(pwd)
cd "$HOME"

VERSION="v1.16.10"
echo "Installing kubectl version $VERSION"
echo "Remember to check the version of your kubernetes cluster, as the client must be +-1 minor version of the cluster"
if [[ "$OSTYPE" == "darwin"* ]]; then
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/darwin/amd64/kubectl"
else
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/linux/amd64/kubectl
fi
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

cd "$cwd"
kubectl version --client
