{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.features.wifi;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.wifi.enable =
    mkEnableOption "Enable Wi-Fi via NetworkManager (desktop-friendly wireless management)";

  config = mkIf cfg.enable {
    # Use NetworkManager for networking (handles Wi-Fi, Ethernet, VPNs)
    networking.networkmanager.enable = true;

    # Optional: uncomment to prefer iwd backend over wpa_supplicant
    # networking.networkmanager.wifi.backend = "iwd";  # requires modern hardware

    # Ensure the applet is available if you use a system tray (HM/Waybar may also show state)
    environment.systemPackages = [ pkgs.networkmanagerapplet ];
    programs.nm-applet.enable = true;
  };
}
