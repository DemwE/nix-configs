{ pkgs, ... }:
{
  users.users.demwe.packages = with pkgs; [
    mpv
    gapless
    ffmpeg-full
  ];
}
