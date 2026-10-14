{ config, ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      user = {
        name = "Mateusz Czarnecki";
        email = "mateuszczarnecki360@gmail.com";
      };
      submodule.recurse = true;
      core.autocrlf = "input";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
}