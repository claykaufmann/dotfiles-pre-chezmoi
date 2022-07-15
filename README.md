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

### [Git](https://git-scm.com) (`.gitconfig`)

My gitconfig is here, pretty simple, mainly just adding the [delta](https://github.com/dandavison/delta) difftool to be the git diff tool.

### [Vim](https://www.vim.org) (`.vimrc`)

This is mostly for archive purposes as I no longer use Vim, but my `.vimrc` file is available for either reference, or if I need to use vim instead of neovim for some reason. NOTE: It does not symlink by default in the setup script.

### `mac/`

In here are my mac specific dotfiles.

#### [ZSH](https://www.zsh.org) (`.zshrc`)

On my mac, I use zsh as it is the default shell. I use [oh-my-zsh](https://ohmyz.sh) to bootstrap my zsh config, and then I use [spaceship](https://spaceship-prompt.sh) to make my terminal look much better as well, to display useful information on the command line.

### `linux/`

In here are my linux specific dotfiles. NOTE: this folder is a work in progress, and should be treated as such. While it does currently work, it by no means may work in a different environment.

#### [bspwm](https://github.com/baskerville/bspwm) (`bspwm/`) - window manager

bspwm is my window manager of choice. It is a tiling window manager.

#### [fish](https://fishshell.com) (`fish/`) - shell

I use fish as my shell on linux, a highly configurable, batteries-included shell. It has great defaults, and good autocomplete. The core config file is `config.fish`

#### gtk (`gtk-2.0/`, `gtk-3.0/`) - theming

These are my GTK config files, they just set UI themes.

#### [pywal](https://github.com/dylanaraps/pywal) (`walstart.sh`) - colorschemes

Pywal is a tool that creates colorschemes based on background images. The referenced file, `walstart.sh` starts up pywal, selects a random background image from my background images folder, updates apps that use pywal, and sets the respective background image that pywal is currently using with [feh](https://feh.finalrewind.org).

#### [polybar](https://github.com/polybar/polybar) (`polybar/`) - status bar

I use polybar as my status bar. In here are polybar scripts, my `launch.sh`, and the config file.

#### [rofi](https://github.com/davatorium/rofi) (`rofi/`) - window switcher / app launcher

An alternative to dmenu, rofi is my window switcher of choice. Core config file is `config.rasI`

#### [spicetify](https://spicetify.app) (`spicetify/`) - spotify modifier

Spicetify is an application that allows users to modify how spotify looks. I further modified it to work with pywal, making my spotify sync in appearance with my entire desktop.

#### [sxhkd](https://github.com/baskerville/sxhkd) (`sxkhd/`) - hotkey manager

sxhkd manages all of my hotkeys for bspwm, and more.

#### [picom](https://github.com/yshui/picom) (`picom.conf`) - compositor

The core function of picom is to add transparency to different applications.

#### [starship](https://starship.rs) (`starship.toml`) - shell prompt

I use starship as my shell prompt, it works well with fish, and looks good. Also is easily configurable. This config file adds a bunch of extra symbols to the prompt.

#### `.profile`

My `.profile` does only a couple things, set some `$PATH` vars, and then it sets sxhkd to use normal shell instead of fish, dramatically speeding it up.

#### `dbx_start.sh`

This just starts up dropbox, its called with a `systemctl` call upon my computer booting up.

#### `mimeapps.list`

Sets some default applications.
