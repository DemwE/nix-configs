{ config, pkgs, ... }:

{
  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    git = true;
    icons = "auto";
    theme = builtins.fromYAML (builtins.readFile "${config.my.paths.resources}/eza-theme.yml");
  };
}
