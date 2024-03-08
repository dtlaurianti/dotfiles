# lsd
alias ls='lsd'
alias ll='lsd -al'
alias la='lsd -a'
alias l='lsd -A'
alias lr='lsd -AR'
alias llr='lsd -alR'
alias lt='lsd -a --tree -I".git"'
alias ldt='lsd -d --tree'
alias llt='lsd -ag --tree --long -I".git"'
alias lgtm='lsd -ag --tree --long -I"node_modules" -I"dist" -I"coverage" -I".git"'

# git
alias gs='git status -u && git stash list'
alias gf='git fetch --all --tags'
alias gcm='git commit -m'
alias gacm='git add -A && git commit -m'
alias gg='git-graph'
alias gri='git rebase -i'
alias lz='lazygit'

# docker
alias dc='docker compose'
alias dcub='docker compose up --build'

# nixos
alias nrs='sudo nixos-rebuild switch'
alias nxc='sudo nvim /etc/nixos/'

# other
alias nv='nvim .'
alias tmux="tmux -f ~/.config/tmux/tmux.conf"
alias fzf='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias y='yarn'
