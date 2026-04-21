{ ... }:
{
  # NixBook uses DemwEPC as a remote builder
  my.remoteBuilder.buildHosts = [
    {
      hostName = "192.168.7.151";
      user = "demwe";
      sshKey = "/root/.ssh/builder_key";
      system = "x86_64-linux";
      maxJobs = 16;
      speedFactor = 2;
      supportedFeatures = [ "kvm" "big-parallel" ];
      mandatoryFeatures = [ ];
    }
  ];
}