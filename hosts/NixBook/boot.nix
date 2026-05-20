{ ... }:
{
  my.boot.kernel = "unstable";
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "26G";
  boot.kernelParams = [
    "pcie_aspm.policy=powersave"
    "nvme_core.default_ps_max_latency_us=0"
  ];
}
