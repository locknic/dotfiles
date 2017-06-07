#!/bin/bash
set -e

echo "Installing dotfiles..."

# Set bash profile
cat ./bash_profile > ~/.bash_profile

# Add vimrcs to vimrc
cat ./vimrcs/personal.vim > ./vimrc
cat ./vimrcs/basic.vim >> ./vimrc

# Symlink vimrc to ~/.vimrc
ln -sfv ~/src/dotfiles/vimrc ~/.vimrc
