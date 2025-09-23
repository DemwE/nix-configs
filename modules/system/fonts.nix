{ pkgs, ... }:
{
  # Core font set: JetBrainsMono Nerd Font + Noto (broad Unicode coverage)
  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono noto-fonts ];
}
