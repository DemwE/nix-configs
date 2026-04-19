{ config, pkgs, ... }:
{
  programs.oh-my-posh = {
    enable = true;
    useTheme = "catppuccin";
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
}
