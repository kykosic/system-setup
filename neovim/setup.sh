#!/bin/bash
set -e

cwd=$(pwd)

echo "Installing nodejs and yarn"
if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install nodejs yarn
else
    curl -sL install-node.now.sh | sudo bash
    curl --compressed -o- -L https://yarnpkg.com/install.sh | sudo bash
fi

echo "Installing neovim"
sudo chown -R $USER /opt
cd /opt
if [[ "$OSTYPE" == "darwin"* ]]; then
    ARCHIVE=nvim-macos.tar.gz
    DIR=nvim-osx64
else
    ARCHIVE=nvim-linux64.tar.gz
    DIR=nvim-linux64
fi
curl -fLo $ARCHIVE https://github.com/neovim/neovim/releases/download/v0.5.0/$ARCHIVE
tar xzf $ARCHIVE
ln -s /opt/$DIR/bin/nvim /usr/local/bin/nvim
rm $ARCHIVE


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
:CocInstall coc-rust-analyzer coc-pyright coc-go coc-json coc-snippets coc-yaml


For python, you can set interpreterwith:
:CocCommand
Search "python.setInterpreter" and select
"

cd $cwd
