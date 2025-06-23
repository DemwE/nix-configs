{ config, ... }:
{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    shellIntegration.enableZshIntegration = true;
    enableGitIntegration = true;

    settings = {
      window_padding_width = 4;
    };
  };
}
