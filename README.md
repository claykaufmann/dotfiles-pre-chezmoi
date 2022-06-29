# Dotfiles

These are my dotfiles. This repo is used for both mac and linux.

## Installation

1. Clone this repo
2. cd into the repo
3. Run `chmod u+x setup.sh` in order to give executable permissions on the setup script
4. Run `./setup.sh` to install dotfiles. NOTE: Remember to read scripts before running them to understand what they do.

## Folder Structure

The following section describes each folder and file, and what they are for.

### [Doom Emacs](https://github.com/hlissner/doom-emacs) (`doom/`)

My doom config is in `doom/`. I have been using emacs, and doom emacs for a few months now, and I really like it. Check out `config.org` for the majority of my configuration.

NOTE: This doom emacs configuration currently only really works on mac, some work needs to be done on it in order to make it cross-compatible with linux. For now, hesitate from installing this on linux, issues will arise!

### [Kitty](https://github.com/kovidgoyal/kitty) (`kitty/`)

I use kitty as my terminal emulator on both macOS and Linux. It is GPU-accelerated, simple, and works well out of the box.

### [Neovim](https://neovim.io) (`nvim/`)

I occassionally use neovim for quick text editing in the terminal.

### Git (`.gitconfig`)

My gitconfig is here, pretty simple, mainly just adding the [delta](https://github.com/dandavison/delta) difftool to be the git diff tool.

### Vim (`.vimrc`)

This is mostly for archive purposes as I no longer use Vim, but my `.vimrc` file is available for either reference, or if I need to use vim instead of neovim for some reason. NOTE: It does not symlink by default in the setup script.

### `mac/`

In here are my mac specific dotfiles.

#### [ZSH](https://www.zsh.org) (`.zshrc`)

I use [oh-my-zsh](https://ohmyz.sh) to bootstrap my zsh config, and then I use [spaceship](https://spaceship-prompt.sh) to make my terminal look much better as well, to display useful information on the command line.

### `linux/`

In here are my linux specific dotfiles. NOTE: this folder is a work in progress, and should be treated as such. While it does currently work, it by no means may work in a different environment.
