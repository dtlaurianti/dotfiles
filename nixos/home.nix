{ config, lib, pkgs, ... }:
{
    home.username = "dtl";
    home.homeDirectory = "/home/dtl";

    home.packages = with pkgs; [
# fill with user-specific packages
    ];

    programs.git = {
        enable = true;
        userName = "Dylan Laurianti";
        userEmail = "dtlaurianti@gmail.com";
    };

    programs.neovim = {
        enable = true;
# Path to your init.lua file relative to the project root (replace with your actual path)
        extraConfig = lib.fileContents ../nvim/init.lua;
    };

    home.stateVersion = "23.11";

    programs.home-manager.enable = true;
}
