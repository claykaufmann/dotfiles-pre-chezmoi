#! /bin/bash

# detect OS, as different dotfiles should be installed depending on mac or linux
if [[ $OSTYPE == 'darwin'* ]]; then
    echo 'macOS'
fi
