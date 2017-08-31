#!/bin/bash
set -e

dir=$(pwd -P)

echo "Installing dotfiles..."

# Set bash profile
cat $dir/configs/bash_profile > ~/.bash_profile

# Add vimrcs to vimrc
cat $dir/configs/vimrcs/personal.vim > $dir/configs/vimrc
cat $dir/configs/vimrcs/generate.vim >> $dir/configs/vimrc

# Symlink vimrc to ~/.vimrc
ln -sfv $dir/configs/vimrc ~/.vimrc

# Symlink init.vim to ~/.config/nvim/init.vim
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config/nvim}
ln -sfv $dir/configs/vimrc $XDG_CONFIG_HOME/init.vim

# Symlink tmux.conf to ~/.tmux.conf
ln -sfv $dir/configs/tmux.conf ~/.tmux.conf

# Set tmux conf file
tmux source-file ~/.tmux.conf

# Install brew files
sh $dir/install/brew.sh

