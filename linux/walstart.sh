wal -i $HOME/Dropbox/bg-photos
pywalfox update
feh --bg-scale "$(< "${HOME}/.cache/wal/wal")"
