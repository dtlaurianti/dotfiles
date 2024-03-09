# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of grep and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Start SSH Agent
#----------------------------

SSH_ENV="$HOME/.ssh/environment"

function run_ssh_env {
  . "${SSH_ENV}" > /dev/null
}

function start_ssh_agent {
  echo "Initializing new SSH agent..."
  ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo "succeeded"
  chmod 600 "${SSH_ENV}"

  run_ssh_env;

}

if [ -f "${SSH_ENV}" ]; then
  run_ssh_env;
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_ssh_agent;
  }
else
  start_ssh_agent;
fi

# add ssh-keys at startup
if ! ssh-add -l | grep -q "RSA"; then
	ssh-add /root/.ssh/nix_rsa
fi

# activate autojump
. /usr/share/autojump/autojump.sh

# set bat theme
export BAT_THEME="tokyonight_night"

# set config location
export XDG_CONFIG_HOME='~/.config'

# set prompt to starship
eval "$(starship init bash)"

# set editor to neovim
export EDITOR="/usr/local/bin/nvim"
. "$HOME/.cargo/env"

# node
export NODE_ENV='development'

# android studio connection
alias adb='/lib/android-sdk/platform-tools/adb'
export PATH="/lib/android-sdk/platform-tools:$PATH"

# Android SDK
export ANDROID_HOME=~/Android

export ANDROID_SDK_ROOT=~/Android

export PATH=$PATH:$ANDROID_HOME/bin
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin

export ADB_SERVER_SOCKET=tcp:$WSL_HOST:5037

# tmuxifier
export PATH="$PATH:$HOME/.config/tmux/plugins/tmuxifier/bin"
eval "$(tmuxifier init -)"

# start tmux on terminal start, keep at bottom
if [ -z "$TMUX" ]; then
    tmux attach || tmux new -s
fi
