{ config, lib, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    theme = {
      config = toString ./config-resources/yazi-theme.toml;
    };
  };
}
