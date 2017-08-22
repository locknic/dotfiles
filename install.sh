#!/bin/bash
set -e

echo "Installing dotfiles..."

# Set bash profile
cat ./configs/bash_profile > ~/.bash_profile

# Add vimrcs to vimrc
cat ./configs/vimrcs/personal.vim > ./configs/vimrc
cat ./configs/vimrcs/zack.vim >> ./configs/vimrc

# Symlink vimrc to ~/.vimrc
ln -sfv ./configs/vimrc ~/.vimrc

# Symlink init.vim to ~/.config/nvim/init.vim
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config/nvim}
ln -sfv /configs/vimrc $XDG_CONFIG_HOME/init.vim

# Install brew files
sh ./install/brew.sh

