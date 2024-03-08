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

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
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
	ssh-add /root/.ssh/wsl_id_rsa
fi
# Configure prompt
PS1='\[\e[32m\]\u@\h\[\e[39m\]:\[\e[94m\]\w \[\e[36m\]$(__git_ps1 "(%s)")\[\e[39m\]\$ '

# activate autojump
. /usr/share/autojump/autojump.sh

# set bat theme
export BAT_THEME="tokyonight_night"

# set config location
export XDG_CONFIG_HOME='/root/.config'

# set prompt to starship
eval "$(starship init bash)"

# set editor to neovim
export EDITOR="/usr/local/bin/nvim"
. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)
export ADB_SERVER_SOCKET=tcp:$WSL_HOST:5037

autonvm() {
	nvm_path=$(nvm_find_up .nvmrc | tr -d '\n')

	# If there are no .nvmrc file, use the default nvm version
	if [[ ! $nvm_path = *[^[:space:]]* ]]; then

		if [[ -z $nvm_default_version ]]; then
			nvm_default_version=$(nvm version default);
		fi

		# If there is no default version, set it to `node`
		# This will use the latest version on your machine
		if [[ $nvm_default_version == "N/A" ]]; then
			nvm alias default node;
			nvm_default_version=$(nvm version default);
		fi

		# If the current version is not the default version, set it to use the default version
		if [[ $(nvm current) != $nvm_default_version ]]; then
			nvm use default;
		fi

	elif [[ -s $nvm_path/.nvmrc && -r $nvm_path/.nvmrc ]]; then
		nvm_version=$(<"$nvm_path"/.nvmrc)

		# `nvm ls` will check all locally-available versions
		# If there are multiple matching versions, take the latest one
		# Remove the `->` and `*` characters and spaces
		# `nvm_local_version` will be `N/A` if no local versions are found
		if [[ -z $nvm_local_version ]]; then
			nvm_local_version=$(nvm ls --no-colors "$nvm_version" | tail -1 | tr -d '\->*' | tr -d '[:space:]')
		fi

		# If it is not already installed, install it
		# `nvm install` will implicitly use the newly-installed version
		if [[ "$nvm_local_version" == "N/A" ]]; then
			nvm install "$nvm_version";
		elif [[ $(nvm current) != "$nvm_local_version" ]]; then
			nvm use "$nvm_version";
		fi
	fi
}
export PROMPT_COMMAND="autonvm; $PROMPT_COMMAND"

# tmuxifier
export PATH="$PATH:$HOME/.config/tmux/plugins/tmuxifier/bin"
eval "$(tmuxifier init -)"

# start tmux on terminal start, keep at bottom
if [ -z "$TMUX" ]; then
    tmux attach || tmux new -s
fi
