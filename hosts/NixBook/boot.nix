{ ... }:
{
  my.boot.kernel = "unstable";
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "26G";
  boot.kernelParams = [
    "pcie_aspm.policy=powersave"
    "nvme_core.default_ps_max_latency_us=0"
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 8;
}
