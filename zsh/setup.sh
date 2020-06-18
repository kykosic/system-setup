#!/bin/bash
set -e

echo "Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Installing Powerlevel10k"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

echo "Copying config files"
cwd=$(pwd)
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )"
cd "$dir"
cp .zshrc "$HOME"
cp .p10k.zsh "$HOME"
cd "$cwd"