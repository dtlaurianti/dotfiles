{ config, pkgs, ... }:
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

    home.stateVersion = "23.11";

    programs.home-manager.enable = true;
}
