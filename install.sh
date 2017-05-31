#!/bin/bash
set -e

echo "Installing dotfiles..."

# Symlink vimrc to ~/.vimrc
ln -sfv ~/src/dotfiles/vimrc ~/.vimrc
