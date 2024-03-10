{ pkgs, config, ... }:
{
    programs.tmux = {
        enable = true;

        plugins = with pkgs; [
                tmuxPlugins.catppuccin
                tmuxPlugins.continuum
                tmuxPlugins.sensible
                tmuxPlugins.vim-tmux-navigator
                tmuxPlugins.extrakto
        ];

    };
}
