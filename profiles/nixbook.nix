{ ... }:
{
  imports = [
    ./base.nix # Base profile (kept for future shared logic)
  ];

  my.features.hyprland.enable = true;
  my.features.sddm.enable = true;
  my.features.docker.enable = false;
  my.features.qemu.enable = false;
  my.features.polkit.enable = true;
  my.features.bluetooth.enable = true;
  # my.features.gnome.enable = true;

  my.desktop = {
    # Check available options in modules/desktop.nix
  };
}
