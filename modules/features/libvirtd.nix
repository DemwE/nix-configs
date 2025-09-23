{ lib, config, pkgs, ... }:
let
  cfg = config.my.features.libvirtd;
  inherit (lib) mkEnableOption mkIf;
 in {
  options.my.features.libvirtd.enable = mkEnableOption "Enable libvirtd virtualization stack";
  config = mkIf cfg.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [ (pkgs.OVMF.override { secureBoot = true; tpmSupport = true; }).fd ];
        };
      };
    };
    environment.systemPackages = [ pkgs.qemu pkgs.virt-manager ];
  };
}
