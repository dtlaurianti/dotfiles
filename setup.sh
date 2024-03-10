## bash configs
export SUDO_USER=$(logname)

sudo rm /home/$SUDO_USER/.bashrc  
sudo ln -s /home/$SUDO_USER/.config/.bashrc /home/$SUDO_USER/.bashrc 
sudo rm /home/$SUDO_USER/.bash_profile
sudo ln -s  /home/$SUDO_USER/.config/.bash_profile /home/$SUDO_USER/.bash_profile
sudo rm /home/$SUDO_USER/.bash_aliases
sudo ln -s  /home/$SUDO_USER/.config/.bash_aliases /home/$SUDO_USER/.bash_aliases
# nixos configs
sudo rm /etc/nixos/configuration.nix
sudo ln -s /home/$SUDO_USER/.config/nixos/configuration.nix /etc/nixos/configuration.nix
sudo rm /etc/nixos/hardware-configuration.nix
sudo ln -s /home/$SUDO_USER/.config/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
sudo rm /etc/nixos/flake.nix
sudo ln -s /home/$SUDO_USER/.config/nixos/flake.nix /etc/nixos/flake.nix
# keyd configs
sudo rm /etc/keyd/default.conf
sudo cp /home/$SUDO_USER/.config/keyd/default.conf /etc/keyd/default.conf
# bat themes
bat cache --build
