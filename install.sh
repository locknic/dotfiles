#!/bin/bash
set -e

dir=$(pwd -P)

echo "Installing dotfiles..."

# Add vimrcs to vimrc
cat $dir/configs/vim/vimrcs/personal.vim > $dir/configs/vim/vimrc

# Symlink vimrc to ~/.vimrc
ln -sfv $dir/configs/vim/vimrc ~/.vimrc

# Symlink init.vim to ~/.config/nvim/init.vim
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config/nvim}
ln -sfv $dir/configs/vim/vimrc $XDG_CONFIG_HOME/init.vim

# Symlink tmux.conf to ~/.tmux.conf
ln -sfv $dir/configs/tmux.conf ~/.tmux.conf

# Set tmux conf file
tmux source-file ~/.tmux.conf || true

# Git
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global url."git@github.com:".insteadOf "https://github.com/"

# Set bash profile
cat $dir/configs/bash_profile > ~/.bash_profile
source ~/.bash_profile

echo "Success"

