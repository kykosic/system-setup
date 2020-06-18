#!/bin/bash
set -e

echo "Installing Conda"
if [[ "$OSTYPE" == "darwin"* ]]; then
    filename="Miniconda3-latest-MacOSX-x86_64.sh"
else
    filename="Miniconda3-latest-Linux-x86_64.sh"
fi

cwd=$(pwd)
cd "$HOME"

curl -o "$filename" "https://repo.anaconda.com/miniconda/$filename"
sh "$filename"
rm "$filename"

source ~/.zshrc

echo "Creating 'dev' virutal environment"
conda create -n dev python=3.7
source ~/.zshrc