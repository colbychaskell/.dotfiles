# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~

setopt extended_glob null_glob

path=(
  $path             # Keep existing PATH entries
  $HOME/.local/bin  # Add user-locally installed apps
  $SCRIPTS          # Add user scripts
)

# Remove duplicate entries and non-existent directories
typeset -U path
path=($^path(N-/))

export PATH

# ~~~~~~~~~~~~~~~ SSH ~~~~~~~~~~~~~~~~~~~~~~~~

# Give highest precedence to the SSH_AUTH_SOCK value, if it is set, to allow
# ssh-agent forwarding from container hosts or SSH clients.

# Start the SSH agent with a lifetime of 4 hours if not running already
# From Arch wiki.

if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
  # If SSH agent socket does not exist, create one
  if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 4h > "$XDG_RUNTIME_DIR/ssh-agent.env"
  fi

  # Set variables for newly created SSH agent
  source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

# Set to superior editing mode
set -o vi

export VISUAL=nvim
export EDITOR=nvim

# directories
export REPOS="$HOME/Repos"
export GHREPOS="$REPOS/github.com"
export SCRIPTS="$HOME/.local/scripts"
export ZETTELKASTEN="$HOME/Zettelkasten"

# Paths used by Go
export GOBIN="$HOME/.local/bin"
export GOPRIVATE="*.gitlab.com/*"
export GOPATH="$HOME/go/"

# Set the root for a default vcpkg install
export VCPKG_ROOT="$HOME/vcpkg"

# Use Neovim to browse manual pages
export MANPAGER='nvim +Man!'


# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_SPACE  # Don't save when prefixed with space
setopt HIST_IGNORE_DUPS   # Don't save duplicate lines
setopt SHARE_HISTORY      # Share history between sessions

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

# Set the configuration location
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Initialize Starship
eval "$(starship init zsh)"

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

# Most used alias
alias v=nvim
alias t=tmux

alias scripts='cd $SCRIPTS'

# Get local aliases if available
if [ -f "$XDG_CONFIG_HOME/zsh/.zsh_aliases" ]; then
  source "$XDG_CONFIG_HOME/zsh/.zsh_aliases" > /dev/null
fi

alias repos='cd $REPOS'
alias ghrepos='cd $GHREPOS'
alias dot='cd $GHREPOS/colbychaskell/dotfiles'

# ls
alias ls='ls --color=auto'
alias la='ls -lathr'

# finds all files recursively and sorts by last modification, ignore hidden files
alias lastmod='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

# Zettelkasten
alias in="cd \$ZETTELKASTEN/0\ Inbox/"

alias fgk='flux get kustomizations'

# ~~~~~~~~~~~~~~~ Sourcing ~~~~~~~~~~~~~~~~~~~~~~~~

# Machine-specific zsh rc
if [ -f "$HOME/.zsh_local" ]; then
  source "$HOME/.zsh_local"
fi

# Setup fzf
source <(fzf --zsh)


# ~~~~~~~~~~~~~~~ Completion ~~~~~~~~~~~~~~~~~~~~~~~~

fpath+=~/.zfunc

# Add brew package completions if brew is installed
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

autoload -Uz compinit
compinit -u

zstyle ':completion:*' menu select

# ~~~~~~~~~~~~ tmux auto-launch ~~~~~~~~~~~~~~~~~~~~~
if [ -z "$TMUX" ]
then
    tmux attach -t TMUX || tmux new -s TMUX
fi
