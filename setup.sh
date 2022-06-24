#! /bin/bash

# detect OS, as different dotfiles should be installed depending on mac or linux
# NOTE: This is not setup to work on windows AT ALL for now

if [[ $OSTYPE == 'darwin'* ]]; then
    echo 'Detected macOS operating system, will install mac specific files.'
fi

# get the directory this script was run in for symlink purposes
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Installing files from the directory $SCRIPT_DIR"

echo "Symlinking .gitconfig..."
ln -s $SCRIPT_DIR/.gitconfig ~/.gitconfig

echo "Symlinking Doom Emacs config..."
ln -s $SCRIPT_DIR/doom ~/.config/doom

echo "Symlinking kitty config..."
ln -s $SCRIPT_DIR/kitty ~/.config/kitty

echo "Symlinking nvim config..."
ln -s $SCRIPT_DIR/nvim ~/.config/nvim

# if we are on mac, install mac specific dotfiles
ismac=0
if [[ $OSTYPE == 'darwin'* ]]; then
    echo 'Installing macOS specific files...'
    ismac=1
    echo "Symlinking .zshrc..."
    # if this is on mac, we need to symlink specific stuff, namely zsh in the mac folder
    ln -s $SCRIPT_DIR/mac/.zshrc ~/.zshrc

else
    # else, install linux specific dotfiles
    ismac=0
    echo "Installing linux specific files..."

    ln -s $SCRIPT_DIR/linux/bspwm ~/.config/bspwm
    ln -s $SCRIPT_DIR/linux/fish ~/.config/fish
    ln -s $SCRIPT_DIR/linux/picom.conf ~/.config/
    ln -s $SCRIPT_DIR/linux/polybar ~/.config/polybar
    ln -s $SCRIPT_DIR/linux/rofi ~/.config/rofi
    ln -s $SCRIPT_DIR/linux/starship.toml ~/.config/
    ln -s $SCRIPT_DIR/linux/sxhkd ~/.config/sxhkd
fi

echo "Successfully installed dotfiles."
