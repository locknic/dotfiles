#!/bin/bash
set -e

echo "Installing dotfiles..."

# Set bash profile
cat ./configs/bash_profile > ~/.bash_profile

# Add vimrcs to vimrc
cat ./configs/vimrcs/personal.vim > ./vimrc
cat ./configs/vimrcs/basic.vim >> ./vimrc

# Symlink vimrc to ~/.vimrc
ln -sfv ./configs/vimrc ~/.vimrc

# Install brew files
sh ./install/brew.sh

