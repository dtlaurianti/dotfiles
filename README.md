### tmux latest install (outdated on apt repo)
install any dependency packages needed for building
```
sudo apt-get install -y exuberant-ctags cmake libevent-dev libncurses5-dev
```
download link from official http://tmux.github.io/ site
```
wget https://github.com/tmux/tmux/releases/download/2.0/tmux-2.0.tar.gz
tar xvf tmux-2.0.tar.gz
cd tmux-2.0
./configure && make
```
install
```
cp tmux /usr/bin/tmux
```
