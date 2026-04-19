{ config, pkgs, ... }:

{
  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    git = true;
    icons = "auto";
  };

  home.file.".config/eza/theme.yml".source = "${config.my.paths.resources}/eza-theme.yml";
}
