# call pywal
wal -i $HOME/Dropbox/bg-photos-linux

# update firefox colors
pywalfox update

# update background image
feh --bg-scale "$(< "${HOME}/.cache/wal/wal")"
