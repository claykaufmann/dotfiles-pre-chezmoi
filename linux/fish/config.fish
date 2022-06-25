if status is-interactive
    # Commands to run in interactive sessions can go here
end
starship init fish | source

fish_add_path ~/.emacs.d/bin
fish_add_path /home/clayk/.local/bin/
alias ll="ls -la"
