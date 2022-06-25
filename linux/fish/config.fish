if status is-interactive
    # Commands to run in interactive sessions can go here
end

# add to path
fish_add_path ~/.emacs.d/bin
fish_add_path /home/clayk/.local/bin/

# aliases
alias ll="ls -la"
alias dbx="dropbox"

# add starship
starship init fish | source

fish_add_path /home/clayk/.spicetify
