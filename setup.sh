#! /bin/bash

# detect OS, as different dotfiles should be installed depending on mac or linux
# NOTE: This is not setup to work on windows AT ALL for now
# make config directory if it does not already exist
mkdir -p ~/.config

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
    ln -s $SCRIPT_DIR/linux/picom.conf ~/.config/picom.conf
    ln -s $SCRIPT_DIR/linux/polybar ~/.config/polybar
    ln -s $SCRIPT_DIR/linux/rofi ~/.config/rofi
    ln -s $SCRIPT_DIR/linux/starship.toml ~/.config/starship.toml
    ln -s $SCRIPT_DIR/linux/sxhkd ~/.config/sxhkd
    ln -s $SCRIPT_DIR/linux/gtk-2.0 ~/.config/gtk-2.0
    ln -s $SCRIPT_DIR/linux/gtk-3.0 ~/.config/gtk-3.0
    ln -s $SCRIPT_DIR/linux/mimeapps.list ~/.config/mimeapps.list
    ln -s $SCRIPT_DIR/linux/spicetify ~/.config/spicetify

    # this is needed to set the SXHKD shell, so it runs faster
    ln -s $SCRIPT_DIR/linux/.profile ~/.profile
 fi

echo "Successfully installed dotfiles."
