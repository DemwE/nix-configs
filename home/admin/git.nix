{ config, ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    extraConfig =  {
      submodule.recurse = true;
    };
  };
}