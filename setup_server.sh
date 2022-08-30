#! /bin/bash

# this script sets up my dotfiles for use in a linux SERVER environment
# it is a minimal install that just symlinks a couple rc files for easier use

# install vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" $> /dev/null && pwd )

# symlink vimrc
ln -s $SCRIPT_DIR/server-linux/.vimrc ~/.vimrc

# symlink bashrc
ln -s $SCRIPT_DIR/server-linux/.bashrc ~/.bashrc

