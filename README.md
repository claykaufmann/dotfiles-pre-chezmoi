# Dotfiles
These are my dotfiles. I use GNU Stow to symlink them into my `$HOME` directory. 

## [Doom Emacs](https://github.com/hlissner/doom-emacs)
My doom config is in `doom/.doom.d`. When I get a chance, I want to fix this folder name, but that will require some more in-depth stow config, as well as changing the `DOOMDIR` var in emacs. I'm not going to deal with it for now.

I have been using emacs, and doom emacs for a few months now, and I really like it. Check out `config.org` for the majority of my configuration.

## Vim
I rarely use vim now as I get more and more into emacs, but sometimes I want to quickly edit something on the command line, and vim is great for that. I have a barebones git config, just NEOTree, a couple random plugins, and the gruvbox theme. 

## ZSH
ZSH is my shell of choice. My config here mostly just has some aliases, and some `$PATH` management.

## Git
my gitconfig is here, pretty simple, mainly just adding the [delta](https://github.com/dandavison/delta) difftool to be the git diff tool.
