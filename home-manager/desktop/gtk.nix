{ config, pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        size = "standard";
        variant = "mocha";
      };
      name = "catppuccin-mocha-lavender-standard";
    };

    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
      name = "Papirus-Dark";
    };

    gtk3.extraConfig = {
      gtk-theme-name = "catppuccin-mocha-lavender-standard";
      gtk-icon-theme-name = "Papirus-Dark";
    };
    
    gtk4.extraConfig = {
      gtk-theme-name = "catppuccin-mocha-lavender-standard";
      gtk-icon-theme-name = "Papirus-Dark";
    };
  };
}