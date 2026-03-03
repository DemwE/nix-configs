{ lib, config, pkgs, ... }:
/*
  Feature: Howdy (IR Camera / Windows Hello)
  Provides: Face-recognition login at the GDM screen only.
  Enabling this feature will:
   - import the services.howdy NixOS module from nixpkgs-unstable
     (services.howdy does not exist in NixOS 25.11, only in unstable)
   - enable the howdy daemon using pkgs.unstable.howdy
   - restrict howdy PAM to gdm-password only (not sudo or polkit)
   - enable the IR emitter (services.linux-enable-ir-emitter)
   - set the IR camera device node (default: /dev/video2 for ThinkPad X1 Gen 4)
  After first rebuild, run: sudo howdy add
  to register your face.
*/
let
  # Both services.howdy and services.linux-enable-ir-emitter only exist in
  # nixpkgs-unstable. builtins.fetchTarball has no dependency on pkgs/config
  # so it's safe to use in imports. Same URL as overlays/unstable.nix —
  # nix reuses the git cache, no second download.
  unstable = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  };
  cfg = config.my.features.howdy;
  inherit (lib) mkEnableOption mkIf;
in
{
  imports = [
    "${unstable}/nixos/modules/services/security/howdy"
    "${unstable}/nixos/modules/services/misc/linux-enable-ir-emitter.nix"
  ];

  options.my.features.howdy.enable =
    mkEnableOption "Enable face recognition login via Howdy (IR camera, unstable)";

  config = mkIf cfg.enable {
    services.howdy = {
      enable = true;
      package = pkgs.unstable.howdy;
      settings.video.device_path = "/dev/video2";
    };
    # GDM sets gdm-password/gdm-fingerprint .text directly — .rules are ignored.
    # Use mkBefore on .text to prepend howdy at the top of each auth stack.
    # Note: enableGnomeKeyring is also lost when .text is overridden.
    # Keyring auto-unlocks only on password login; for face/fingerprint set an
    # empty keyring password in Seahorse (safe if LUKS encryption is enabled).
    security.pam.services.gdm-fingerprint.text = lib.mkBefore ''
      auth      sufficient  ${pkgs.unstable.howdy}/lib/security/pam_howdy.so
    '';
    security.pam.services.gdm-password.text = lib.mkBefore ''
      auth      sufficient  ${pkgs.unstable.howdy}/lib/security/pam_howdy.so
    '';
    # Enable the IR emitter so the camera works in the dark
    # Package only exists in unstable, override the default pkgs lookup
    services.linux-enable-ir-emitter = {
      enable = true;
      package = pkgs.unstable.linux-enable-ir-emitter;
    };
  };
}
