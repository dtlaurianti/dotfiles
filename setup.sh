## bash configs
export SUDO_USER=$(logname)

rm /home/$SUDO_USER/.bashrc  
ln -s /home/$SUDO_USER/.config/.bashrc /home/$SUDO_USER/.bashrc 
rm /home/$SUDO_USER/.bash_profile
ln -s  /home/$SUDO_USER/.config/.bash_profile /home/$SUDO_USER/.bash_profile
rm /home/$SUDO_USER/.bash_aliases
ln -s  /home/$SUDO_USER/.config/.bash_aliases /home/$SUDO_USER/.bash_aliases
# nixos configs
rm /etc/nixos/configuration.nix
ln -s /home/$SUDO_USER/.config/nixos/configuration.nix /etc/nixos/configuration.nix
rm /etc/nixos/hardware-configuration.nix
ln -s /home/$SUDO_USER/.config/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
rm /etc/nixos/flake.nix
ln -s /home/$SUDO_USER/.config/nixos/flake.nix /etc/nixos/flake.nix
# keyd configs
rm /etc/keyd/default.conf
ln -s /home/$SUDO_USER/.config/keyd/default.conf /etc/keyd/default.conf
