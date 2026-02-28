{ config, pkgs, ... }:
{
  programs.gnome-shell.enable = true;
  programs.gnome-shell.extensions = [
    { package = pkgs.gnomeExtensions.blur-my-shell; }
    { package = pkgs.gnomeExtensions.appindicator; }
    { package = pkgs.gnomeExtensions.ulauncher-toggle; }
    { package = pkgs.gnomeExtensions.clipboard-indicator; }
  ];

  gtk = {
    enable = true;
    
    theme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
    
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    
    # GTK3 apps: force dark mode via legacy setting
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
}