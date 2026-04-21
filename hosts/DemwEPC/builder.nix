{ ... }:
{
  # DemwEPC acts as a remote builder for other machines
  my.remoteBuilder.config = {
    enableExternalBuilding = true;
    maxJobs = "auto";
  };
}
