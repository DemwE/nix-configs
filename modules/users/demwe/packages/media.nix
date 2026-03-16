{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs; [
    mpv
    ffmpeg-full
  ];
}
