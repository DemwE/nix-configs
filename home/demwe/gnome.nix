{ config, pkgs, ... }:
{
  programs.gnome-shell.enable = true;
  programs.gnome-shell.extensions = [
    { package = pkgs.gnomeExtensions.blur-my-shell; }
    { package = pkgs.gnomeExtensions.appindicator; }
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
}