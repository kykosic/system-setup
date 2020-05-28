#!/bin/bash
set -e

cwd=$(pwd)

echo "Installing nodejs and yarn"
if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install nodejs yarn
else
    curl -sL install-node.now.sh | sh
    curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
fi

echo "Installing neovim"
sudo chown -R $USER /opt
cd /opt
curl -fLo nvim-macos.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
tar xzf nvim-macos.tar.gz
ln -s /opt/nvim-osx64/bin/nvim /usr/local/bin/nvim
rm nvim-macos.tar.gz


echo "Installing vim-plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Copying config"
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )"
cd "$dir"
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim
cp coc-settings.json ~/.config/nvim

echo "Installing python provider"
pip install neovim

echo "
To complete installation, open a neovim seesion and run:
:PlugInstall

Additionally, install language support with:
:CocInstall coc-json
:CocInstall coc-python
:CocInstall coc-snippets
:CocInstall coc-tsserver
:CocInstall coc-yaml
:CocInstall coc-rust-analyzer
:CocInstall coc-java
"
read -n 1 -p "Press any key to continue" var

cd $cwd
