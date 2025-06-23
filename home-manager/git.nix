{ config, ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Mateusz Czarnecki";
    userEmail = "mateuszczarnecki360@gmail.com";
  };
}
