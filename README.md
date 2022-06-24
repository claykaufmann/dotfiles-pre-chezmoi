# Dotfiles

These are my dotfiles. This repo is used for both mac and linux.

## Installation
1. Clone this repo
2. cd into the repo
3. Run `chmod u+x setup.sh` in order to give executable permissions on the setup script
4. Run `./setup.sh` to install dotfiles. NOTE: Remember to read scripts before running them to understand what they do.


## Folder Structure

The following section describes each folder and file, and what they are for.

### [Doom Emacs](https://github.com/hlissner/doom-emacs) (`/doom`)

My doom config is in `doom/.doom.d`. When I get a chance, I want to fix this folder name, but that will require some more in-depth stow config, as well as changing the `DOOMDIR` var in emacs. I'm not going to deal with it for now.

I have been using emacs, and doom emacs for a few months now, and I really like it. Check out `config.org` for the majority of my configuration.

### [Kitty](https://github.com/kovidgoyal/kitty) (`/kitty`)

I use kitty as my terminal emulator on both macOS and Linux. It is GPU-accelerated, simple, and works well out of the box.

### [Neovim](https://neovim.io) (`/nvim`)

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

In here are my linux specific dotfiles. NOTE: These are not complete at all, and are currently not installed with the setup script as I need to do more configuration with them.
