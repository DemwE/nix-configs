{ ... }:
{
  imports = [
    ./home.nix
    ./packages.nix
  ];

  users.users.demwe = {
    isNormalUser = true;
    description = "DemwE";
    extraGroups = [ "networkmanager" "wheel" "storage" "plugdev" "libvirtd" "docker" ];
  };
}
