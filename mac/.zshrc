# set starship as main prompt
eval "$(starship init zsh)"

# enable sheldon plugins
eval "$(sheldon source)"

# Set main editor
export EDITOR=/opt/homebrew/bin/nvim
export VISUAL=/opt/homebrew/bin/nvim

# ~~~~~~~ ALIASES ~~~~~~~
alias ls='ls --color=auto'
alias ll='ls -la'
alias l.='ls --color=auto -d .* '

# git
alias gs='git status'
alias g='git'

# kitty ssh fixes
alias kssh="kitty +kitten ssh"

# vim
alias vim='nvim'

# test doom alias
alias doom-test='~/doom-emacs-test/bin/doom'

# launch doom alias
alias emacs-test='emacs --with-profile doom-test'

# ~~~~~~~ CONFIG SETUP ~~~~~~~
# ~~~ pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# activate pyenv/virtualenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# ~~~ nvm
export NVM_DIR="$HOME/.nvm"

# load nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 

# load bash completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ~~~ poetry
export PATH="/Users/claykaufmann/.local/bin:$PATH"

# ~~~ emacs path modification
export PATH="$HOME/.emacs.d/bin:$PATH"

# ~~~ llvm/c
# export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/Applications/CMake.app/Contents/bin":"$PATH"

# ~~~ yarn path modification
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node-modules/.bin:$PATH"

# ~~~ EMACS PATH EXTRAS ~~~
export PATH="/opt/homebrew/Cellar/emacs-plus@28/28.1/bin:$PATH"

# ~~~ DOOM PATHS ~~~
export PATH="$HOME/doom-emacs/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/mamba.sh" ]; then
    . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

export VIRTUAL_ENV_DISABLE_PROMPT=true
