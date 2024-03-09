rm ~/.bashrc 
ln -s /home/$SUDO_USER/config/.bashrc ~/.bashrc 
rm ~/.bash_profile
ln -s  /home/$SUDO_USER/config/.bash_profile ~/.bash_profile
rm ~/.bash_aliases
ln -s  /home/$SUDO_USER/config/.bash_aliases ~/.bash_aliases
rm /etc/nixos/configuration.nix
ln -s /home/$SUDO_USER/config/nixos/configuration.nix /etc/nixos/configuration.nix
rm /etc/nixos/hardware-configuration.nix
ln -s /home/$SUDO_USER/config/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
rm /etc/nixos/flake.nix
ln -s /home/$SUDO_USER/config/nixos/flake.nix /etc/nixos/flake.nix
