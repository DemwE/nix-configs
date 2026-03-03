{ lib, pkgs, ... }:
{
  # Specialisation: Intel-only (dGPU disabled for max battery life)
  specialisation.igpu-only.configuration = {
    my.features.nvidia.enable = lib.mkForce false;
    my.features.nvidia.finegrainedPowerManagement = lib.mkForce false;
    my.features.nvidia.prime.enable = lib.mkForce false;
    boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_uvm" "nvidia_drm" "nvidia_modeset" ];
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{power/control}="auto"
    '';
    # Override nvidia-offload with a no-op passthrough so launch options don't break
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "nvidia-offload" ''exec "$@"'')
    ];
  };

  # Specialisation: dGPU-only — NVIDIA renders everything via PRIME sync (max performance)
  specialisation.dgpu-only.configuration = {
    my.features.nvidia.finegrainedPowerManagement = lib.mkForce false;
    my.features.nvidia.prime.mode = lib.mkForce "sync";
  };
}
