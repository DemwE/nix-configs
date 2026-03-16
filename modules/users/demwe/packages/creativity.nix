{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs; [
    unstable.gimp
    unstable.blender
    unstable.obs-studio
    unstable.krita
    unstable.aseprite
  ];
}
