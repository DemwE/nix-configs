{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs; [
    gimp
    blender
    unstable.obs-studio
    unstable.krita
    unstable.aseprite
  ];
}
