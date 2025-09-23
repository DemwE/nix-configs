{ config, pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    plugins = {
      yatline-catppuccin = pkgs.yaziPlugins.yatline-catppuccin;
      git = pkgs.yaziPlugins.git;
      nvim = pkgs.vimPlugins.yazi-nvim;
    };
  theme = builtins.fromTOML (builtins.readFile "${config.my.paths.resources}/yazi-theme.toml");
  };
}
