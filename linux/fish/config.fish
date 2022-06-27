if status is-interactive
    # Commands to run in interactive sessions can go here
    set -Ux PYENV_ROOT $HOME/.pyenv
    set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
end

# pyenv setup
pyenv init - | source

# nvm setup
nvm use node > /dev/null 2>&1

# add to path
fish_add_path ~/.emacs.d/bin
fish_add_path /home/clayk/.local/bin/

# aliases
alias ll="ls -la"
alias dbx="dropbox"

# map vi to nvim, faster than typing vim
# also if something goes wrong with nvim, can easily use vim
alias vi="nvim"

# add starship
starship init fish | source

fish_add_path /home/clayk/.spicetify

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/clayk/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

